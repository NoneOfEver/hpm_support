=========================================
Docker Environment Configuration Guide
=========================================

Using **Docker** is the fastest way to set up the Zephyr development environment for HPMicro. No need to install dependencies manually - everything is pre-configured in the container.

Prerequisites
--------------

Before starting, ensure you have:

- Docker installed on your system
- (Optional) Docker Compose for easier container management
- USB access for flashing (Linux recommended)

Pulling the Docker Image
--------------------------

You can pull the Docker image from either **DockerHub** or **Alibaba Cloud ACR**.

From DockerHub
~~~~~~~~~~~~~~~

.. code-block:: console

    docker pull swhpmicro/zephyr-hpmicro:v0.7.0

From Alibaba Cloud ACR
~~~~~~~~~~~~~~~~~~~~~~~

For faster download speeds in China, use the Alibaba Cloud mirror:

.. code-block:: console

    docker pull crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0

Downloading Zephyr SDK
------------------------

The Zephyr SDK is required but not included in the Docker image (due to size). Download and extract it:

.. code-block:: console

    mkdir ~/zephyr-hpmicro && cd ~/zephyr-hpmicro
    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.5/zephyr-sdk-0.16.5_linux-x86_64.tar.xz
    tar xvf zephyr-sdk-0.16.5_linux-x86_64.tar.xz
    cd zephyr-sdk-0.16.5 && ./setup.sh -t all -h -c && cd ..


Method 1: Using Docker Run
----------------------------

This method is suitable for quick testing or one-time use.

Basic Usage
~~~~~~~~~~~~

.. code-block:: console

    docker run -it --rm \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

With USB Device Access (for Flashing)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To flash firmware to your board, you need USB device access:

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

With Custom Project Directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To mount your own project directory:

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        -v ~/my_projects:/home/zephyr/zephyr_space/my_projects \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

Using Alibaba Cloud Image with Docker Run
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simply replace the image name:

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0 \
        bash


Method 2: Using Docker Compose
--------------------------------

Docker Compose provides a more convenient way to manage the container with persistent configuration.

Step 1: Extract docker-compose.yaml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    cd ~/zephyr-hpmicro
    docker run --rm swhpmicro/zephyr-hpmicro:v0.7.0 cat /home/zephyr/docker-compose.user.yaml > docker-compose.yaml

Or for Alibaba Cloud image:

.. code-block:: console

    docker run --rm crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0 cat /home/zephyr/docker-compose.yaml > docker-compose.yaml

Step 2: Edit docker-compose.yaml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you pulled from Alibaba Cloud, edit the image line in ``docker-compose.yaml``:

.. code-block:: yaml

    services:
      zephyr-dev:
        image: crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0

Step 3: Start the Container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose up -d

Step 4: Enter the Container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose exec zephyr-dev bash

Step 5: Stop the Container
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose down


Directory Structure
---------------------

After setup, your working directory should look like this:

.. code-block:: text

    ~/zephyr-hpmicro/
    ├── docker-compose.yaml      # Docker Compose configuration
    ├── zephyr-sdk-0.16.5/       # Zephyr SDK (downloaded)
    │   ├── setup.sh
    │   ├── sdk_version
    │   └── ...
    └── my_projects/             # Optional: Your custom projects

Inside the container:

.. code-block:: text

    /home/zephyr/zephyr_space/
    ├── bootloader/              # (embedded in image)
    ├── modules/                 # (embedded in image)
    ├── sdk_env/                 # HPMicro SDK (embedded)
    ├── sdk_glue/                # (embedded in image)
    ├── zephyr/                  # Zephyr source (embedded)
    │   └── samples/             # Sample projects to build
    ├── zephyr-sdk-0.16.5/       # (mounted from host)
    └── my_projects/             # (optional, mounted from host)


Building and Flashing
-----------------------

Once inside the container, you can build and flash samples:

#. Build a sample

    .. code-block:: console

        cd /home/zephyr/zephyr_space/zephyr
        west build -p always -b hpm6750evk2 -S blinky samples/basic/blinky

#. Flash to target (connect your board first)

    .. code-block:: console

        west flash

#. Debug

    .. code-block:: console

        west debug

Available Boards
~~~~~~~~~~~~~~~~~~

.. code-block:: console

    west boards | grep hpm

Common boards include:

- ``hpm6750evk2``
- ``hpm6800evk``
- ``hpm6200evk``
- ``hpm6e00evk``


Troubleshooting
-----------------

Zephyr SDK Not Found
~~~~~~~~~~~~~~~~~~~~~

Make sure the ``zephyr-sdk-0.16.5`` folder is correctly mounted and you ran ``setup.sh`` inside it:

.. code-block:: console

    cd ~/zephyr-hpmicro/zephyr-sdk-0.16.5
    ./setup.sh -t all -h -c

Cannot Flash - Device Not Found
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Check if debugger is connected:

    .. code-block:: console

        lsusb | grep -i xxx

#. Ensure ``--privileged`` flag is used (docker run) or ``privileged: true`` is set (docker-compose)

#. Verify ``/dev/bus/usb`` is mounted

Permission Denied on Serial Device
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add your user to the dialout group on the host:

.. code-block:: console

    sudo usermod -aG dialout $USER

Then logout and login again.

Using a Different SDK Version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Set the environment variable before starting:

.. code-block:: console

    export ZEPHYR_SDK_PATH=./zephyr-sdk-0.17.0
    docker compose up -d


