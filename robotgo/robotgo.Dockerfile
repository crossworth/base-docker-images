FROM golang:1.23-bookworm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    # robotgo https://github.com/go-vgo/robotgo#ubuntu
    && apt-get install -y gcc libc6-dev libx11-dev xorg-dev libxtst-dev  \
    libpng++-dev libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev libxkbcommon-dev
