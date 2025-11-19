# Copyright (c) 2025 HPMicro
# SPDX-License-Identifier: Apache-2.0

# Configures binary tools as GNU binutils

find_program(CMAKE_OBJCOPY ${CROSS_COMPILE}llvm-objcopy PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_OBJDUMP ${CROSS_COMPILE}llvm-objdump PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_AR      ${CROSS_COMPILE}llvm-ar      PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_RANLIB  ${CROSS_COMPILE}llvm-ranlib  PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_READELF ${CROSS_COMPILE}llvm-readelf PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_NM      ${CROSS_COMPILE}llvm-nm      PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)
find_program(CMAKE_STRIP   ${CROSS_COMPILE}llvm-strip   PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)

find_program(CMAKE_GDB     ${CROSS_COMPILE}zdb  PATHS ${TOOLCHAIN_HOME} NO_DEFAULT_PATH)

# Include bin tool properties
include(${TOOLCHAIN_ROOT}/cmake/bintools/zcc/target_bintools.cmake)
