/*
 * Copyright (c) 2025 HPMicro
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 */

		. = ALIGN(8);
		KEEP(*(.init._start))
		KEEP(*(.start))