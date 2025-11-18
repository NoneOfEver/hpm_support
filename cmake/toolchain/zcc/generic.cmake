# Copyright (c) 2025 HPMicro
# SPDX-License-Identifier: Apache-2.0

zephyr_get(ZCC_TOOLCHAIN_PATH)
assert(    ZCC_TOOLCHAIN_PATH "ZCC_TOOLCHAIN_PATH is not set")

if(NOT EXISTS ${ZCC_TOOLCHAIN_PATH}) 
  message(FATAL_ERROR "Nothing found at ZCC_TOOLCHAIN_PATH: '${ZCC_TOOLCHAIN_PATH}'")
endif()

set(TOOLCHAIN_HOME ${ZCC_TOOLCHAIN_PATH})
set(COMPILER zcc)
set(LINKER ld.lld)
set(BINTOOLS gnu)
set(CROSS_COMPILE ${TOOLCHAIN_HOME}/bin/)
set(C++ z++)

message(STATUS "Found toolchain: zcc (${ZCC_TOOLCHAIN_PATH})")
