# Copyright (c) 2023-2024 HPMicro
# SPDX-License-Identifier: Apache-2.0

if(CONFIG_SDHC)
    zephyr_library_amend()
    zephyr_library_sources_ifdef(CONFIG_SDHC_HPMICRO sdhc_hpmicro.c)
endif()
