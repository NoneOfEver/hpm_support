#!/bin/bash
# =============================================================================
# Docker Build Script for Zephyr HPMicro Development Environment
# =============================================================================
# This script handles the Docker image build process, including:
# - Copying .dockerignore to build context root
# - Building the Docker image
# - Cleaning up temporary files
#
# Usage:
#   ./docker-build.sh [local|remote] [additional docker build args]
#
# Examples:
#   ./docker-build.sh local
#   ./docker-build.sh local --no-cache
#   ./docker-build.sh remote
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSG_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_header() { echo -e "${CYAN}=== $1 ===${NC}"; }

# Default values
BUILD_TYPE="${1:-local}"
shift 2>/dev/null || true
EXTRA_ARGS="$@"

# Validate build type
if [[ "$BUILD_TYPE" != "local" && "$BUILD_TYPE" != "remote" ]]; then
    log_error "Invalid build type: $BUILD_TYPE"
    echo "Usage: $0 [local|remote] [additional docker build args]"
    exit 1
fi

DOCKERFILE="${SCRIPT_DIR}/dockerfile.${BUILD_TYPE}"
IMAGE_TAG="zephyr_hpmicro:${BUILD_TYPE}"
DOCKERIGNORE_SRC="${SCRIPT_DIR}/.dockerignore"
DOCKERIGNORE_DST="${ZSG_ROOT}/.dockerignore"

log_header "Building Zephyr HPMicro Docker Image (${BUILD_TYPE})"

# Check if Dockerfile exists
if [[ ! -f "$DOCKERFILE" ]]; then
    log_error "Dockerfile not found: $DOCKERFILE"
    exit 1
fi

# Copy .dockerignore to build context root
DOCKERIGNORE_COPIED=false
if [[ -f "$DOCKERIGNORE_SRC" ]]; then
    # Check if destination already exists and is different
    if [[ -f "$DOCKERIGNORE_DST" ]]; then
        if ! diff -q "$DOCKERIGNORE_SRC" "$DOCKERIGNORE_DST" >/dev/null 2>&1; then
            log_warn "Existing .dockerignore in ZSG root differs from sdk_glue version"
            log_warn "Backing up to .dockerignore.bak"
            cp "$DOCKERIGNORE_DST" "${DOCKERIGNORE_DST}.bak"
        fi
    fi
    log_info "Copying .dockerignore to build context root..."
    cp "$DOCKERIGNORE_SRC" "$DOCKERIGNORE_DST"
    DOCKERIGNORE_COPIED=true
else
    log_warn ".dockerignore not found in sdk_glue, building without ignore file"
fi

# Cleanup function
cleanup() {
    if [[ "$DOCKERIGNORE_COPIED" == "true" && -f "$DOCKERIGNORE_DST" ]]; then
        log_info "Cleaning up .dockerignore from build context root..."
        rm -f "$DOCKERIGNORE_DST"
        # Restore backup if exists
        if [[ -f "${DOCKERIGNORE_DST}.bak" ]]; then
            mv "${DOCKERIGNORE_DST}.bak" "$DOCKERIGNORE_DST"
        fi
    fi
}

# Set trap to cleanup on exit
trap cleanup EXIT

# Get user UID/GID for proper permissions
USER_UID=$(id -u)
USER_GID=$(id -g)

log_info "Build context: ${ZSG_ROOT}"
log_info "Dockerfile: ${DOCKERFILE}"
log_info "Image tag: ${IMAGE_TAG}"
log_info "User UID/GID: ${USER_UID}/${USER_GID}"

# Build the image
log_header "Running Docker Build"
docker build \
    -f "$DOCKERFILE" \
    -t "$IMAGE_TAG" \
    --build-arg USER_UID="$USER_UID" \
    --build-arg USER_GID="$USER_GID" \
    $EXTRA_ARGS \
    "$ZSG_ROOT"

BUILD_STATUS=$?

if [[ $BUILD_STATUS -eq 0 ]]; then
    log_header "Build Successful!"
    log_info "Image: ${IMAGE_TAG}"
    
    # Show image size
    IMAGE_SIZE=$(docker images "$IMAGE_TAG" --format "{{.Size}}" 2>/dev/null || echo "unknown")
    log_info "Size: ${IMAGE_SIZE}"
    
    echo ""
    log_info "To run the container:"
    if [[ "$BUILD_TYPE" == "local" ]]; then
        echo "  cd ${SCRIPT_DIR}"
        echo "  docker-compose --profile local up -d zephyr-local"
        echo "  docker-compose --profile local exec zephyr-local /bin/bash"
        echo ""
        echo "Or run directly:"
        echo "  docker run -it --rm \\"
        echo "    -v /path/to/zephyr-sdk-0.16.5:/opt/zephyr-sdk:ro \\"
        echo "    --device=/dev/ttyUSB0 \\"
        echo "    ${IMAGE_TAG}"
    else
        echo "  cd ${SCRIPT_DIR}"
        echo "  docker-compose --profile remote up -d zephyr-remote"
        echo "  docker-compose --profile remote exec zephyr-remote /bin/bash"
    fi
else
    log_error "Build failed with exit code: ${BUILD_STATUS}"
    exit $BUILD_STATUS
fi

exit 0

