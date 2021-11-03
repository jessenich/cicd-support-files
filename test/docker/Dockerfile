ARG VARIANT=11
FROM debian:"$VARIANT"

ARG TZ=America_NewYork
ENV TZ=${TZ}

COPY ./rootfs /

RUN apt-get update && \
    apt-get install -y \
        zsh \
        zdb  \
        sudo && \
    adduser --disabled-password --gecos '' docker && \
    adduser docker sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN sudo apt-get update
WORKDIR /home/docker/scripts
COPY scripts ./


