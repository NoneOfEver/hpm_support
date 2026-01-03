#!/bin/bash
# Docker entrypoint script for Zephyr HPMicro development environment
# Supports both embedded source mode (source in image) and mounted source mode
# Handles zephyr-sdk setup when mounted at runtime

set -e

WORKSPACE="${WORKSPACE:-/home/zephyr/zephyr_space}"
WEST_MANIFEST="${WEST_MANIFEST:-west_gitee.yml}"
ZEPHYR_SDK_VERSION="${ZEPHYR_SDK_VERSION:-0.16.5}"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_header() {
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
}

# Check if we're in embedded source mode (source code copied into image)
EMBEDDED_SOURCE=false
if [ -f "${WORKSPACE}/.docker_embedded_source" ]; then
    EMBEDDED_SOURCE=true
fi

log_header "Zephyr HPMicro Development Environment"

if [ "$EMBEDDED_SOURCE" = true ]; then
    log_info "Mode: Embedded source (source code in image)"
else
    log_info "Mode: Mounted source (source code from host)"
fi

# Check workspace
if [ ! -d "${WORKSPACE}" ]; then
    log_error "Workspace not found at ${WORKSPACE}"
    if [ "$EMBEDDED_SOURCE" = false ]; then
        log_error "Please mount your ZSG directory:"
        log_error "  docker run -v /path/to/ZSG:${WORKSPACE} ..."
    fi
    exit 1
fi

cd "${WORKSPACE}"

# ============================================================================
# Zephyr SDK Setup
# ============================================================================
# SDK should be mounted at ${WORKSPACE}/zephyr-sdk-${ZEPHYR_SDK_VERSION}
# (same level as sdk_glue, zephyr, modules, etc.)
# ============================================================================

log_info "Checking Zephyr SDK..."

# Define possible SDK locations (in order of preference)
SDK_SEARCH_PATHS=(
    "${WORKSPACE}/zephyr-sdk-${ZEPHYR_SDK_VERSION}"
    "${WORKSPACE}/zephyr-sdk-${ZEPHYR_SDK_VERSION}-1"
    "${WORKSPACE}/zephyr-sdk"
    "/opt/zephyr-sdk-${ZEPHYR_SDK_VERSION}"
    "/opt/zephyr-sdk"
)

# Find the SDK
ZEPHYR_SDK_INSTALL_DIR=""
for SDK_PATH in "${SDK_SEARCH_PATHS[@]}"; do
    if [ -d "${SDK_PATH}" ] && [ -f "${SDK_PATH}/sdk_version" ]; then
        ZEPHYR_SDK_INSTALL_DIR="${SDK_PATH}"
        break
    fi
done

if [ -n "${ZEPHYR_SDK_INSTALL_DIR}" ]; then
    SDK_VERSION=$(cat "${ZEPHYR_SDK_INSTALL_DIR}/sdk_version" 2>/dev/null || echo "unknown")
    log_info "Zephyr SDK found at: ${ZEPHYR_SDK_INSTALL_DIR}"
    log_info "SDK Version: ${SDK_VERSION}"
    
    # Export for use in build commands
    export ZEPHYR_SDK_INSTALL_DIR
    
    # ========================================================================
    # Run setup.sh to register CMake package
    # ========================================================================
    # The setup.sh script registers the SDK with CMake so that find_package()
    # can locate the SDK. This is required for Zephyr builds.
    #
    # Options used:
    #   -t all  : Setup all available toolchains
    #   -h      : Install/setup host tools
    #   -c      : Register CMake package (critical for builds!)
    # ========================================================================
    
    CMAKE_PACKAGE_FILE="${ZEPHYR_SDK_INSTALL_DIR}/cmake/zephyr-sdk-use-file.cmake"
    CMAKE_REGISTRY_DIR="${HOME}/.cmake/packages/Zephyr-sdk"
    
    # Check if CMake package is already registered
    SDK_SETUP_NEEDED=false
    
    if [ ! -d "${CMAKE_REGISTRY_DIR}" ]; then
        SDK_SETUP_NEEDED=true
        log_info "CMake package not registered, running setup..."
    elif [ ! -f "${CMAKE_REGISTRY_DIR}"/* ] 2>/dev/null; then
        SDK_SETUP_NEEDED=true
        log_info "CMake package registry empty, running setup..."
    fi
    
    if [ "$SDK_SETUP_NEEDED" = true ]; then
        if [ -f "${ZEPHYR_SDK_INSTALL_DIR}/setup.sh" ]; then
            log_info "Running Zephyr SDK setup.sh..."
            # Run setup.sh with:
            #   -t all : all toolchains
            #   -h     : host tools
            #   -c     : CMake package registration
            # Note: We need write access to ~/.cmake for CMake package registration
            pushd "${ZEPHYR_SDK_INSTALL_DIR}" > /dev/null
            bash ./setup.sh -t all -h -c 2>&1 | while read line; do
                echo "  [SDK] $line"
            done
            SETUP_STATUS=${PIPESTATUS[0]}
            popd > /dev/null
            
            if [ $SETUP_STATUS -eq 0 ]; then
                log_info "SDK setup completed successfully"
            else
                log_warn "SDK setup returned non-zero status: $SETUP_STATUS"
                log_warn "Build may still work if toolchains are already configured"
            fi
        else
            log_warn "setup.sh not found in SDK directory"
            log_warn "CMake may not find the SDK during build"
        fi
    else
        log_info "SDK CMake package already registered"
    fi
    
    # Verify CMake can find the SDK
    if [ -d "${CMAKE_REGISTRY_DIR}" ]; then
        log_info "CMake package registered at: ${CMAKE_REGISTRY_DIR}"
    fi
    
else
    log_warn "============================================"
    log_warn "Zephyr SDK not found!"
    log_warn "============================================"
    log_warn ""
    log_warn "Please mount your zephyr-sdk to the workspace:"
    log_warn ""
    log_warn "  docker run -v /path/to/zephyr-sdk-${ZEPHYR_SDK_VERSION}:${WORKSPACE}/zephyr-sdk-${ZEPHYR_SDK_VERSION} ..."
    log_warn ""
    log_warn "Or with docker-compose, set ZEPHYR_SDK_PATH:"
    log_warn ""
    log_warn "  export ZEPHYR_SDK_PATH=/path/to/zephyr-sdk-${ZEPHYR_SDK_VERSION}"
    log_warn "  docker-compose --profile local up -d"
    log_warn ""
    log_warn "Searched locations:"
    for path in "${SDK_SEARCH_PATHS[@]}"; do
        log_warn "  - $path"
    done
    log_warn ""
fi

# ============================================================================
# West Workspace Initialization (only for mounted source mode)
# ============================================================================
if [ "$EMBEDDED_SOURCE" = false ]; then
    if [ ! -f ".west/config" ]; then
        if [ -d "sdk_glue" ]; then
            log_info "Initializing west workspace from local sdk_glue..."
            west init -l sdk_glue
            west config manifest.file ${WEST_MANIFEST}
            log_info "West workspace initialized"
        else
            log_warn "sdk_glue directory not found, skipping west initialization"
        fi
    else
        log_info "West workspace already initialized"
    fi
    
    # Install Python requirements if not already done
    # Check for a key package that indicates requirements are installed
    if [ -d "zephyr" ] && [ -f "zephyr/scripts/requirements.txt" ]; then
        # Check if west.commands.build module exists (indicates zephyr requirements installed)
        if ! python3 -c "from west.commands import build" 2>/dev/null; then
            log_info "Installing Python requirements (this may take a moment)..."
            pip3 install --user --no-cache-dir -r zephyr/scripts/requirements.txt 2>&1 | tail -5 || \
                pip3 install --user --no-cache-dir -r zephyr/scripts/requirements-base.txt 2>&1 | tail -5 || \
                log_warn "Some Python packages failed to install"
            log_info "Python requirements installed"
        fi
    fi
    
    # ========================================================================
    # CRITICAL: Run west zephyr-export to register Zephyr extension commands
    # ========================================================================
    # This registers 'west build', 'west flash', 'west debug' etc.
    # Without this, 'west build' will show "unknown command"
    # ========================================================================
    if [ -d "zephyr" ]; then
        # Check if zephyr-export has been run by looking for the marker
        ZEPHYR_EXPORT_MARKER="${HOME}/.cmake/packages/Zephyr"
        if [ ! -d "${ZEPHYR_EXPORT_MARKER}" ]; then
            log_info "Running west zephyr-export to register build commands..."
            west zephyr-export 2>&1 || log_warn "west zephyr-export failed"
            log_info "Zephyr export completed"
        else
            log_info "Zephyr CMake package already registered"
        fi
    fi
fi

# ============================================================================
# HPM SDK Patches
# ============================================================================
if [ -d "sdk_glue" ] && command -v west >/dev/null 2>&1; then
    if [ ! -f ".west/.supply_done" ]; then
        log_info "Applying HPM SDK patches..."
        west supply 2>/dev/null && touch .west/.supply_done || log_warn "west supply skipped or failed"
    fi
fi

# ============================================================================
# Serial Device Check
# ============================================================================
log_info "Checking serial devices..."
SERIAL_DEVICES=$(ls /dev/ttyUSB* /dev/ttyACM* /dev/ttyDAP* /dev/serial/by-id/* 2>/dev/null | head -5 || true)
if [ -n "$SERIAL_DEVICES" ]; then
    log_info "Available serial devices:"
    echo "$SERIAL_DEVICES" | while read dev; do
        echo "  - $dev"
    done
else
    log_warn "No serial devices found. To use flash/debug, run container with:"
    log_warn "  --device=/dev/ttyUSB0 or --device=/dev/ttyACM0"
fi

# ============================================================================
# OpenOCD Check
# ============================================================================
if command -v openocd >/dev/null 2>&1; then
    OPENOCD_VERSION=$(openocd --version 2>&1 | head -1 || echo "unknown")
    log_info "OpenOCD: ${OPENOCD_VERSION}"
else
    log_warn "OpenOCD not found in PATH"
fi

# ============================================================================
# Environment Summary
# ============================================================================
echo ""
log_header "Environment Ready"
echo ""
log_info "Workspace:  ${WORKSPACE}"
log_info "SDK:        ${ZEPHYR_SDK_INSTALL_DIR:-NOT FOUND}"
log_info "Toolchain:  ${ZEPHYR_TOOLCHAIN_VARIANT:-zephyr}"
echo ""
log_info "Directory structure:"
echo "  ${WORKSPACE}/"
echo "  ├── bootloader/"
echo "  ├── docs/"
echo "  ├── modules/"
echo "  ├── sdk_env/"
echo "  ├── sdk_glue/        <- HPMicro SDK glue layer"
echo "  ├── tools/"
echo "  ├── zephyr/          <- Zephyr RTOS"
if [ -n "${ZEPHYR_SDK_INSTALL_DIR}" ]; then
echo "  └── $(basename ${ZEPHYR_SDK_INSTALL_DIR})/  <- Zephyr SDK (mounted)"
else
echo "  └── zephyr-sdk-X.X.X/  <- Mount SDK here!"
fi
echo ""
log_info "Quick commands:"
echo "  west build -b <board> <sample>   # Build a sample"
echo "  west flash                        # Flash to target"
echo "  west debug                        # Start debugger"
echo ""

# Execute the command passed to docker run
exec "$@"
