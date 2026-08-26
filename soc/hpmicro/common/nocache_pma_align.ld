/*
 * Copyright (c) 2026 HPMicro
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/* Pad a non-empty region to the minimum HPMicro PMA NAPOT granularity. */
. = (. == _nocache_ram_start) ?
	. : MAX(., _nocache_ram_start + CONFIG_HPM_PMA_MIN_REGION_SIZE);
