==========================
Environment Configuration
==========================

Environment setup for Zephyr on different systems.

HPMicro Zephyr supports multiple toolchains. You can choose based on your needs:

.. list-table::
   :header-rows: 1
   :widths: 20 50

   * - Toolchain
     - Description
   * - **Zephyr SDK**
     - Official Zephyr SDK with full functionality and best compatibility. Slower download speed
   * - **zcc Toolchain**
     - LLVM/Clang-based toolchain with fast download and excellent performance
   * - **GNU Cross-Compile Toolchain**
     - Use your existing RISC-V GCC toolchain

.. note::

   | Toolchain installation is **optional**. You can choose any one of them.
   | For detailed toolchain configuration and switching methods, refer to the :doc:`toolchain` section.

.. toctree::
   :maxdepth: 2

   linux
   windows
   docker
   toolchain
