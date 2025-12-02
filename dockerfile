FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USER_NAME=zephyr
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG WORKSPACE=/home/${USER_NAME}/workspace
ARG ZEPHYR_SDK_VERSION=0.16.5
ARG ZEPHYR_SDK_ARCHIVE=zephyr-sdk-${ZEPHYR_SDK_VERSION}_linux-x86_64.tar.xz
ARG ZEPHYR_SDK_URL=https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK_VERSION}/${ZEPHYR_SDK_ARCHIVE}
ARG WEST_MANIFEST=west_gitee.yml

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        cmake \
        ninja-build \
        gperf \
        ccache \
        dfu-util \
        device-tree-compiler \
        wget \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-tk \
        python3-wheel \
        python3-venv \
        xz-utils \
        file \
        make \
        gcc \
        gcc-multilib \
        g++-multilib \
        libsdl2-dev \
        libmagic1 \
        pkg-config \
        tar \
        unzip \
        bzip2 \
        locales \
        udev \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-ca-certificates
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create an unprivileged user that will own the workspace.
RUN groupadd --gid ${USER_GID} ${USER_NAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} --create-home --shell /bin/bash ${USER_NAME} && \
    mkdir -p ${WORKSPACE} && \
    chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}

RUN pip3 install --no-cache-dir west

ENV HOME=/home/${USER_NAME} \
    PATH=/home/${USER_NAME}/.local/bin:/root/.local/bin:$PATH \
    ZEPHYR_TOOLCHAIN_VARIANT=zephyr \
    ZEPHYR_SDK_INSTALL_DIR=${WORKSPACE}/zephyr-sdk-${ZEPHYR_SDK_VERSION} \
    WORKSPACE=${WORKSPACE}

USER ${USER_NAME}
WORKDIR ${WORKSPACE}

# Initialize the workspace directly from the remote manifest repository.
RUN west init -m https://gitee.com/hpmicro/zephyr_sdk_glue.git --mr main && \
    west config manifest.file ${WEST_MANIFEST} && \
    west update && \
    west zephyr-export && \
    pip3 install --no-cache-dir -r zephyr/scripts/requirements.txt && \
    west supply

WORKDIR /tmp

RUN wget -q ${ZEPHYR_SDK_URL} && \
    tar -C ${WORKSPACE} -xf ${ZEPHYR_SDK_ARCHIVE} && \
    rm ${ZEPHYR_SDK_ARCHIVE} && \
    ${ZEPHYR_SDK_INSTALL_DIR}/setup.sh -t all -h && \
    rm -rf ${ZEPHYR_SDK_INSTALL_DIR}/temp

WORKDIR ${WORKSPACE}

CMD ["/bin/bash"]

