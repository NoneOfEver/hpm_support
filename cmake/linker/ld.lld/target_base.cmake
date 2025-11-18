# Copyright (c) 2025 HPMicro
# SPDX-License-Identifier: Apache-2.0

# See root CMakeLists.txt for description and expectations of these macros

macro(toolchain_ld_base)

  if(NOT PROPERTY_LINKER_SCRIPT_DEFINES)
    set_property(GLOBAL PROPERTY PROPERTY_LINKER_SCRIPT_DEFINES -D__LLD_LINKER_CMD__)
  endif()

  # TOOLCHAIN_LD_FLAGS comes from compiler/clang/target.cmake
  # LINKERFLAGPREFIX comes from linker/lld/target.cmake
  zephyr_ld_options(
    ${TOOLCHAIN_LD_FLAGS}
  )

  zephyr_ld_options(
    ${LINKERFLAGPREFIX},--gc-sections
    ${LINKERFLAGPREFIX},--build-id=none
  )

  # Sort each input section by alignment.
  zephyr_ld_option_ifdef(
    CONFIG_LINKER_SORT_BY_ALIGNMENT
    ${LINKERFLAGPREFIX},--sort-section=alignment
  )

  if (NOT CONFIG_LINKER_USE_RELAX)
    zephyr_ld_options(
      ${LINKERFLAGPREFIX},--no-relax
    )
  endif()

  # Global pointer relaxation is off by default in lld. Explicitly enable it if
  # linker relaxations and gp usage are both allowed.
  if (CONFIG_LINKER_USE_RELAX AND CONFIG_RISCV_GP)
    zephyr_ld_options(
      ${LINKERFLAGPREFIX},--andes-relax-gp
    )
  endif()

  if(CONFIG_CPP AND (CMAKE_C_COMPILER_ID STREQUAL "Clang"))
    # LLVM lld complains:
    #   error: section: init_array is not contiguous with other relro sections
    #
    # So do not create RELRO program header.
    zephyr_link_libraries(
      -Wl,-z,norelro
    )
  endif()

  zephyr_link_libraries(
    -Wl,-mllvm,--align-all-nofallthru-blocks=2
  )
  zephyr_link_libraries(
    -falign-functions=4
  )
  zephyr_link_libraries(
    -flate-loop-unroll
  )
  zephyr_link_libraries(
    -Wl,-mllvm,--jump-is-expensive=true
  )
  # if(CONFIG_LIBGCC_RTLIB)
  #   set(runtime_lib "libgcc")
  # elseif(CONFIG_COMPILER_RT_RTLIB)
  #   set(runtime_lib "compiler_rt")
  # endif()

  # zephyr_link_libraries(
  #   --config ${ZEPHYR_BASE}/cmake/toolchain/llvm/clang_${runtime_lib}.cfg
  # )

  # zephyr_link_libraries(
  #   --config ${TOOLCHAIN_HOME}/riscv64-unknown-elf/lib/small.cfg
  # )
endmacro()
