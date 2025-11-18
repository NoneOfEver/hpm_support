/*
 * Copyright (c) 2024-2025 HPMicro
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 */

. = ORIGIN(ROM) + CONFIG_BOOT_NOR_CFG_OPTION_OFFSET;
KEEP(*(.nor_cfg_option))
. = ORIGIN(ROM) + CONFIG_BOOT_HEADER_LOAD_OFFSET;
KEEP(*(.boot_header))
KEEP(*(.fw_info_table))
KEEP(*(.dc_info))