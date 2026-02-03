.. _supported_samples_en:

Board Supported Matrix
=======================

The following samples have been verified on supported development boards.

Table legend:

- **Category**: Sample category
- **Sample**: Sample path
- **Snippet**: Snippet required to run the sample ("-" means not required)
- **Board columns**: ✓ indicates supported, ✗ indicates not supported

.. list-table::
   :header-rows: 1
   :widths: 10 30 18 10 10 10 10
   :class: verified-samples-table

   * - Category
     - Sample
     - Snippet
     - 6750evk2
     - 6800evk
     - 6200evk
     - 6e00evk
   * - Basic
     - samples/hello_world
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - Basic
     - samples/basic/blinky
     - blinky
     - ✓
     - ✓
     - ✓
     - ✓
   * - Basic
     - samples/basic/blinky_pwm
     - blinky_pwm
     - ✓
     - ✗
     - ✓
     - ✓
   * - Basic
     - samples/basic/button
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - Driver
     - samples/drivers/eeprom
     - i2c_eeprom
     - ✓
     - ✓
     - ✗
     - ✓
   * - Display
     - samples/drivers/display
     - display_rgb
     - ✓
     - ✓
     - ✗
     - ✗
   * - Display
     - samples/drivers/display
     - display_mipi
     - ✗
     - ✓
     - ✗
     - ✗
   * - Display
     - samples/drivers/display
     - display_lvds
     - ✗
     - ✓
     - ✗
     - ✗
   * - Display
     - samples/drivers/display
     - display_dual_lvds
     - ✗
     - ✓
     - ✗
     - ✗
   * - Camera
     - samples/subsys/video/capture
     - video_dvp
     - ✓
     - ✓
     - ✗
     - ✗
   * - Camera
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
   * - Network
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
   * - CAN Test
     - tests/drivers/can/api
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN Test
     - tests/drivers/can/timing
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - CAN Test
     - tests/drivers/can/shell
     - can
     - ✓
     - ✓
     - ✓
     - ✓
   * - UART Test
     - tests/drivers/uart/uart_basic_api
     - \-
     - ✓
     - ✓
     - ✓
     - ✓
   * - SDHC Test
     - tests/drivers/sdhc
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC Test
     - tests/drivers/disk/disk_access
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC Test
     - tests/drivers/disk/disk_performance
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC Test
     - tests/subsys/sd/sdmmc
     - sdhc
     - ✓
     - ✓
     - ✗
     - ✗
   * - SDHC Test
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

