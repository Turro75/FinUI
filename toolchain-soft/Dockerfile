FROM arcnor/toolchain-bittboy:steward

LABEL description="Legacy (uClibc/steward) build environment Miyoo Custom Firmware based on arcnor's image" 

# install build dependencies
# first two lines are needed just to build the toolchain
# dosfstools & u-boot-tools are for mainboot generation scripts
# python-dev & swig are needed to build uboot
# finally, run some cleanup
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y make gcc g++ \
    file wget cpio zip unzip rsync bc git \
    dosfstools u-boot-tools \
    mc sharutils imagemagick bsdmainutils \
    python-dev swig && \
    apt-get -y autoremove && apt-get -y clean

COPY ./build /root/build/
WORKDIR /root/build/
# Build and install SDL
RUN ./build-sdl.sh
RUN cat ./setup-env.sh >> /root/.bashrc
RUN mkdir -p /root/buildroot/output/images
RUN gunzip -c rootfs.img.gz > /root/buildroot/output/images/rootfs.ext2 
WORKDIR /root/workspace