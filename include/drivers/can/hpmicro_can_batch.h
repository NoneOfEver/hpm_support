/*
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <stddef.h>

#include <zephyr/device.h>
#include <zephyr/drivers/can.h>
#include <zephyr/kernel.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Submit one explicit secondary-transmit-buffer batch.
 *
 * All frames are loaded before TSALL is asserted.  The callback is invoked
 * once, after the complete batch has been transmitted successfully.
 */
int hpm_can_send_batch(const struct device *dev,
		       const struct can_frame *frames,
		       size_t frame_count,
		       k_timeout_t timeout,
		       can_tx_callback_t callback,
		       void *user_data);

#ifdef __cplusplus
}
#endif
