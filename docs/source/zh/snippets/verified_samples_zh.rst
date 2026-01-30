.. _supported_samples_zh:

支持示例
============

以下示例已在支持的开发板上验证通过。

表格说明：

- **类别**: 示例所属类别
- **示例**: 示例路径
- **配置文件**: 运行示例需要的 snippet（"-" 表示不需要）
- **开发板列**: ✓ 表示支持，✗ 表示不支持

.. list-table::
   :header-rows: 1
   :widths: 10 30 18 10 10 10 10
   :class: verified-samples-table

   * - 类别
     - 示例
     - 配置文件
     - 6750evk2
     - 6800evk
     - 6200evk
     - 6e00evk
   * - 基础
     - samples/hello_world
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - 基础
     - samples/basic/blinky
     - blinky
     - ✓
     - ✓
     - ✓
     - ✓
   * - 基础
     - samples/basic/blinky_pwm
     - blinky_pwm
     - ✓
     - ✗
     - ✓
     - ✓
   * - 基础
     - samples/basic/button
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - 驱动
     - samples/drivers/eeprom
     - i2c_eeprom
     - ✓
     - ✓
     - ✗
     - ✓
   * - 显示
     - samples/drivers/display
     - display_rgb
     - ✓
     - ✓
     - ✗
     - ✗
   * - 显示
     - samples/drivers/display
     - display_mipi
     - ✗
     - ✓
     - ✗
     - ✗
   * - 显示
     - samples/drivers/display
     - display_lvds
     - ✗
     - ✓
     - ✗
     - ✗
   * - 显示
     - samples/drivers/display
     - display_dual_lvds
     - ✗
     - ✓
     - ✗
     - ✗
   * - 摄像头
     - samples/subsys/video/capture
     - video_dvp
     - ✓
     - ✓
     - ✗
     - ✗
   * - 摄像头
     - samples/subsys/video/capture
     - video_mipi
     - ✗
     - ✓
     - ✗
     - ✗
   * - USB
     - samples/subsys/usb/cdc_acm
     - cdc_acm
     - ✓
     - ✓
     - ✓
     - ✓
   * - USB
     - samples/subsys/usb/hid-keyboard
     - hid-keyboard
     - ✓
     - ✓
     - ✓
     - ✓
   * - USB
     - samples/subsys/usb/hid-mouse
     - hid-mouse
     - ✓
     - ✓
     - ✓
     - ✓
   * - USB
     - samples/subsys/usb/mass
     - mass
     - ✓
     - ✓
     - ✓
     - ✓
   * - 网络
     - samples/net/sockets/echo_server
     - ethernet
     - ✓
     - ✓
     - ✗
     - ✓
   * - Shell
     - samples/subsys/shell/shell_module
     - shell_module
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN
     - samples/modules/canopennode
     - canopennode
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN 测试
     - tests/drivers/can/api
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN 测试
     - tests/drivers/can/timing
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN 测试
     - tests/drivers/can/shell
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - UART 测试
     - tests/drivers/uart/uart_basic_api
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - SDHC 测试
     - tests/drivers/sdhc
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC 测试
     - tests/drivers/disk/disk_access
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC 测试
     - tests/drivers/disk/disk_performance
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC 测试
     - tests/subsys/sd/sdmmc
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC 测试
     - tests/subsys/sd/mmc
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - CherryUSB
     - cherryusb/device/msc/ram_disk
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - CherryUSB
     - cherryusb/device/cdc_acm/cdc_acm_vcom
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - CherryUSB
     - cherryusb/host/cdc_acm
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - CherryUSB
     - cherryusb/host/msc_disk
     - \-
     - ✓
     - ✓
     - ✓
     - ✓

