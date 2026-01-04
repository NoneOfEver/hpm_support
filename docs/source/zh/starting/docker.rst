====================================
Docker 环境配置
====================================

使用 **Docker** 是配置 HPMicro Zephyr 开发环境最快捷的方式。无需手动安装依赖，容器中已预先配置好所有环境。

前置条件
---------

开始之前，请确保：

- 已安装 Docker
- （可选）已安装 Docker Compose，便于容器管理
- USB 访问权限（用于烧录，推荐使用 Linux）

拉取 Docker 镜像
------------------

您可以从 **DockerHub** 或 **阿里云 ACR** 拉取 Docker 镜像。

从 DockerHub 拉取
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker pull swhpmicro/zephyr-hpmicro:v0.7.0

从阿里云 ACR 拉取
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

国内用户推荐使用阿里云镜像，下载速度更快：

.. code-block:: console

    docker pull crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0

下载 Zephyr SDK
-----------------

Zephyr SDK 是必需的，但由于体积较大，未包含在 Docker 镜像中。请下载并解压：

.. code-block:: console

    mkdir ~/zephyr-hpmicro && cd ~/zephyr-hpmicro
    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.5/zephyr-sdk-0.16.5_linux-x86_64.tar.xz
    tar xvf zephyr-sdk-0.16.5_linux-x86_64.tar.xz
    cd zephyr-sdk-0.16.5 && ./setup.sh -t all -h -c && cd ..


方法一：使用 Docker Run
-------------------------

此方法适合快速测试或一次性使用。

基本用法
~~~~~~~~~

.. code-block:: console

    docker run -it --rm \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

启用 USB 设备访问（用于烧录）
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

烧录固件到开发板需要 USB 设备访问权限：

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

挂载自定义项目目录
~~~~~~~~~~~~~~~~~~~~

如需挂载您自己的项目目录：

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        -v ~/my_projects:/home/zephyr/zephyr_space/my_projects \
        swhpmicro/zephyr-hpmicro:v0.7.0 \
        bash

使用阿里云镜像运行
~~~~~~~~~~~~~~~~~~~~

只需替换镜像名称即可：

.. code-block:: console

    docker run -it --rm \
        --privileged \
        -v /dev/bus/usb:/dev/bus/usb \
        -v ~/zephyr-hpmicro/zephyr-sdk-0.16.5:/home/zephyr/zephyr_space/zephyr-sdk-0.16.5 \
        crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0 \
        bash


方法二：使用 Docker Compose
-------------------------------------

Docker Compose 提供了更便捷的容器管理方式，配置可持久化保存。

步骤一：提取 docker-compose.yaml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

    cd ~/zephyr-hpmicro
    docker run --rm swhpmicro/zephyr-hpmicro:v0.7.0 cat /home/zephyr/docker-compose.user.yaml > docker-compose.yaml

或使用阿里云镜像：

.. code-block:: console

    docker run --rm crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0 cat /home/zephyr/docker-compose.yaml > docker-compose.yaml

步骤二：编辑 docker-compose.yaml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

如果您从阿里云拉取的镜像，请编辑 ``docker-compose.yaml`` 中的镜像地址：

.. code-block:: yaml

    services:
      zephyr-dev:
        image: crpi-u5o2013t4tqx7y44.cn-beijing.personal.cr.aliyuncs.com/zephyr_hpmicro/sdk_glue:v0.7.0

步骤三：启动容器
~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose up -d

步骤四：进入容器
~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose exec zephyr-dev bash

步骤五：停止容器
~~~~~~~~~~~~~~~~~~

.. code-block:: console

    docker compose down


目录结构
---------

配置完成后，您的工作目录结构如下：

.. code-block:: text

    ~/zephyr-hpmicro/
    ├── docker-compose.yaml      # Docker Compose 配置文件
    ├── zephyr-sdk-0.16.5/       # Zephyr SDK（已下载）
    │   ├── setup.sh
    │   ├── sdk_version
    │   └── ...
    └── my_projects/             # 可选：您的自定义项目

容器内部结构：

.. code-block:: text

    /home/zephyr/zephyr_space/
    ├── bootloader/              # （内置于镜像）
    ├── modules/                 # （内置于镜像）
    ├── sdk_env/                 # HPMicro SDK（内置）
    ├── sdk_glue/                # （内置于镜像）
    ├── zephyr/                  # Zephyr 源码（内置）
    │   └── samples/             # 示例项目
    ├── zephyr-sdk-0.16.5/       # （从主机挂载）
    └── my_projects/             # （可选，从主机挂载）


编译与烧录
-----------

进入容器后，您可以编译和烧录示例程序：

#. 编译示例

    .. code-block:: console

        cd /home/zephyr/zephyr_space/zephyr
        west build -p always -b hpm6750evk2 -S blinky samples/basic/blinky

#. 烧录到目标板（请先连接开发板）

    .. code-block:: console

        west flash

#. 调试

    .. code-block:: console

        west debug

可用开发板
~~~~~~~~~~~~

.. code-block:: console

    west boards | grep hpm

常用开发板包括：

- ``hpm6750evk2``
- ``hpm6800evk``
- ``hpm6200evk``
- ``hpm6e00evk``


常见问题
---------

找不到 Zephyr SDK
~~~~~~~~~~~~~~~~~~~

确保 ``zephyr-sdk-0.16.5`` 文件夹已正确挂载，并且已在其中运行过 ``setup.sh``：

.. code-block:: console

    cd ~/zephyr-hpmicro/zephyr-sdk-0.16.5
    ./setup.sh -t all -h -c

无法烧录 - 找不到设备
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. 检查调试器是否已连接：

    .. code-block:: console

        lsusb | grep -i xxx

#. 确保使用了 ``--privileged`` 参数（docker run）或设置了 ``privileged: true``（docker-compose）

#. 确认 ``/dev/bus/usb`` 已挂载

串口设备权限被拒绝
~~~~~~~~~~~~~~~~~~~~

在主机上将您的用户添加到 dialout 组：

.. code-block:: console

    sudo usermod -aG dialout $USER

然后注销并重新登录。

使用不同版本的 SDK
~~~~~~~~~~~~~~~~~~~~

在启动前设置环境变量：

.. code-block:: console

    export ZEPHYR_SDK_PATH=./zephyr-sdk-0.17.0
    docker compose up -d


