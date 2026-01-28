.. _verified_samples_zh:

已验证的示例
============

以下示例已在支持的开发板上验证通过。

表格说明：

- **类别**: 示例所属类别
- **示例**: 示例路径
- **配置文件**: 运行示例需要的 snippet（"-" 表示不需要）

hpm6750evk2
-----------

.. list-table::
   :header-rows: 1
   :widths: 15 55 30

   * - 类别
     - 示例
     - 配置文件
   * - 基础
     - zephyr/samples/hello_world
     - \-
   * - 基础
     - zephyr/samples/basic/blinky
     - blinky
   * - 基础
     - zephyr/samples/basic/blinky_pwm
     - blinky_pwm
   * - 基础
     - zephyr/samples/basic/button
     - \-
   * - 驱动
     - zephyr/samples/drivers/eeprom
     - i2c_eeprom
   * - 显示
     - zephyr/samples/drivers/display
     - display_rgb
   * - 摄像头
     - zephyr/samples/subsys/video/capture
     - video_dvp
   * - USB
     - zephyr/samples/subsys/usb/cdc_acm
     - cdc_acm
   * - USB
     - zephyr/samples/subsys/usb/hid-keyboard
     - hid-keyboard
   * - USB
     - zephyr/samples/subsys/usb/hid-mouse
     - hid-mouse
   * - USB
     - zephyr/samples/subsys/usb/mass
     - mass
   * - 网络
     - zephyr/samples/net/sockets/echo_server
     - ethernet
   * - Shell
     - zephyr/samples/subsys/shell/shell_module
     - shell_module
   * - CAN
     - zephyr/samples/modules/canopennode
     - canopennode
   * - CAN 测试
     - zephyr/tests/drivers/can/api
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/timing
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/shell
     - can
   * - UART 测试
     - zephyr/tests/drivers/uart/uart_basic_api
     - \-
   * - SDHC 测试
     - zephyr/tests/drivers/sdhc
     - sdhc
   * - SDHC 测试
     - zephyr/tests/drivers/disk/disk_access
     - sdhc
   * - SDHC 测试
     - zephyr/tests/drivers/disk/disk_performance
     - sdhc
   * - SDHC 测试
     - zephyr/tests/subsys/sd/sdmmc
     - sdhc
   * - SDHC 测试
     - zephyr/tests/subsys/sd/mmc
     - sdhc
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/msc/ram_disk
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/cdc_acm/cdc_acm_vcom
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/cdc_acm
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/msc_disk
     - \-

hpm6800evk
----------

.. list-table::
   :header-rows: 1
   :widths: 15 55 30

   * - 类别
     - 示例
     - 配置文件
   * - 基础
     - zephyr/samples/hello_world
     - \-
   * - 基础
     - zephyr/samples/basic/blinky
     - blinky
   * - 基础
     - zephyr/samples/basic/button
     - \-
   * - 驱动
     - zephyr/samples/drivers/eeprom
     - i2c_eeprom
   * - 显示
     - zephyr/samples/drivers/display
     - display_rgb
   * - 显示
     - zephyr/samples/drivers/display
     - display_mipi
   * - 显示
     - zephyr/samples/drivers/display
     - display_lvds
   * - 显示
     - zephyr/samples/drivers/display
     - display_dual_lvds
   * - 摄像头
     - zephyr/samples/subsys/video/capture
     - video_dvp
   * - 摄像头
     - zephyr/samples/subsys/video/capture
     - video_mipi
   * - USB
     - zephyr/samples/subsys/usb/cdc_acm
     - cdc_acm
   * - USB
     - zephyr/samples/subsys/usb/hid-keyboard
     - hid-keyboard
   * - USB
     - zephyr/samples/subsys/usb/hid-mouse
     - hid-mouse
   * - USB
     - zephyr/samples/subsys/usb/mass
     - mass
   * - 网络
     - zephyr/samples/net/sockets/echo_server
     - ethernet
   * - Shell
     - zephyr/samples/subsys/shell/shell_module
     - shell_module
   * - CAN
     - zephyr/samples/modules/canopennode
     - canopennode
   * - CAN 测试
     - zephyr/tests/drivers/can/api
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/timing
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/shell
     - can
   * - UART 测试
     - zephyr/tests/drivers/uart/uart_basic_api
     - \-
   * - SDHC 测试
     - zephyr/tests/drivers/sdhc
     - sdhc
   * - SDHC 测试
     - zephyr/tests/drivers/disk/disk_access
     - sdhc
   * - SDHC 测试
     - zephyr/tests/drivers/disk/disk_performance
     - sdhc
   * - SDHC 测试
     - zephyr/tests/subsys/sd/sdmmc
     - sdhc
   * - SDHC 测试
     - zephyr/tests/subsys/sd/mmc
     - sdhc
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/msc/ram_disk
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/cdc_acm/cdc_acm_vcom
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/cdc_acm
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/msc_disk
     - \-

hpm6200evk
----------

.. list-table::
   :header-rows: 1
   :widths: 15 55 30

   * - 类别
     - 示例
     - 配置文件
   * - 基础
     - zephyr/samples/hello_world
     - \-
   * - 基础
     - zephyr/samples/basic/blinky
     - blinky
   * - 基础
     - zephyr/samples/basic/blinky_pwm
     - blinky_pwm
   * - 基础
     - zephyr/samples/basic/button
     - \-
   * - USB
     - zephyr/samples/subsys/usb/cdc_acm
     - cdc_acm
   * - USB
     - zephyr/samples/subsys/usb/hid-keyboard
     - hid-keyboard
   * - USB
     - zephyr/samples/subsys/usb/hid-mouse
     - hid-mouse
   * - USB
     - zephyr/samples/subsys/usb/mass
     - mass
   * - Shell
     - zephyr/samples/subsys/shell/shell_module
     - shell_module
   * - CAN
     - zephyr/samples/modules/canopennode
     - canopennode
   * - CAN 测试
     - zephyr/tests/drivers/can/api
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/timing
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/shell
     - can
   * - UART 测试
     - zephyr/tests/drivers/uart/uart_basic_api
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/msc/ram_disk
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/cdc_acm/cdc_acm_vcom
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/cdc_acm
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/msc_disk
     - \-

hpm6e00evk
----------

.. list-table::
   :header-rows: 1
   :widths: 15 55 30

   * - 类别
     - 示例
     - 配置文件
   * - 基础
     - zephyr/samples/hello_world
     - \-
   * - 基础
     - zephyr/samples/basic/blinky
     - blinky
   * - 基础
     - zephyr/samples/basic/blinky_pwm
     - blinky_pwm
   * - 基础
     - zephyr/samples/basic/button
     - \-
   * - 驱动
     - zephyr/samples/drivers/eeprom
     - i2c_eeprom
   * - USB
     - zephyr/samples/subsys/usb/cdc_acm
     - cdc_acm
   * - USB
     - zephyr/samples/subsys/usb/hid-keyboard
     - hid-keyboard
   * - USB
     - zephyr/samples/subsys/usb/hid-mouse
     - hid-mouse
   * - USB
     - zephyr/samples/subsys/usb/mass
     - mass
   * - 网络
     - zephyr/samples/net/sockets/echo_server
     - ethernet
   * - Shell
     - zephyr/samples/subsys/shell/shell_module
     - shell_module
   * - CAN
     - zephyr/samples/modules/canopennode
     - canopennode
   * - CAN 测试
     - zephyr/tests/drivers/can/api
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/timing
     - can
   * - CAN 测试
     - zephyr/tests/drivers/can/shell
     - can
   * - UART 测试
     - zephyr/tests/drivers/uart/uart_basic_api
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/msc/ram_disk
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/device/cdc_acm/cdc_acm_vcom
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/cdc_acm
     - \-
   * - CherryUSB
     - sdk_glue/samples/cherryusb/host/msc_disk
     - \-

