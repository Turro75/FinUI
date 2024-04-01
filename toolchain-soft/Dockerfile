FROM docker.io/nfriedly/miyoo-toolchain:steward AS toolchain-source
FROM docker.io/debian:bullseye-slim

# Copy docker-gen binary from build stage
COPY --from=toolchain-source /opt/ /opt

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y make build-essential \
    file wget cpio zip unzip rsync bc git autoconf\ 
    sharutils device-tree-compiler mc imagemagick bsdmainutils \ 
    && apt-get -y autoremove \
    && apt-get -y clean

COPY ./build /root/build/
WORKDIR /root/build/
RUN mkdir -p /root/buildroot/output/images && gunzip -c rootfs.img.gz > /root/buildroot/output/images/rootfs.ext2 

# Build and install SDL
RUN ./build-sdl.sh \
   && cat ./setup-env.sh >> /root/.bashrc 
   # Clean up
#   && rm -rfd /root/build
WORKDIR /root/workspace/

CMD ["/bin/bash"]