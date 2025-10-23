/*
 * Copyright (c) 2025 HPMicro
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 */

#include <zephyr/devicetree.h>
#include <zephyr/sys/util.h>
#include <hpm_common.h>
#include <hpm_soc.h>

uint32_t board_init_femc_clock(void)
{
}

void init_sdram_pins(void)
{
}

void _init_ext_ram(void)
{
}

void sys_arch_reboot(int type)
{
    ARG_UNUSED(type);

    HPM_PPOR->RESET_ENABLE = (1UL << 31);
    HPM_PPOR->SOFTWARE_RESET = 1000U;
    while(1) {

    }
}
