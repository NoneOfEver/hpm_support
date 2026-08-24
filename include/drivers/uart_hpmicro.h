/*
 * Copyright (c) 2026
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef HPMICRO_UART_DRIVER_EXTENSION_H_
#define HPMICRO_UART_DRIVER_EXTENSION_H_

#include <stddef.h>
#include <stdint.h>

#include <zephyr/device.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief 启动 UART RX 硬件循环 DMA。
 *
 * DMA 启动后持续写入 @p buffer，写到 @p size 后由 linked descriptor 自动
 * 回到起点，不经过 stop/reconfigure/start。该模式与 Zephyr UART async RX
 * API 互斥，应用通过 uart_hpm_rx_circular_get_position() 轮询生产者位置。
 */
int uart_hpm_rx_circular_enable(const struct device *dev, uint8_t *buffer, size_t size);

/** @brief 获取循环 DMA 下一字节将写入的位置，范围为 0..size。 */
int uart_hpm_rx_circular_get_position(const struct device *dev, size_t *position);

/** @brief 停止由 uart_hpm_rx_circular_enable() 启动的循环接收。 */
int uart_hpm_rx_circular_disable(const struct device *dev);

#ifdef __cplusplus
}
#endif

#endif /* HPMICRO_UART_DRIVER_EXTENSION_H_ */
