FROM golang:1.22-bookworm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    # robotgo https://github.com/go-vgo/robotgo#ubuntu
    && apt-get install -y gcc libc6-dev libx11-dev xorg-dev libxtst-dev  \
    libpng++-dev libxcb-xkb-dev x11-xkb-utils libx11-xcb-dev libxkbcommon-x11-dev libxkbcommon-dev \
    # opencv https://gocv.io/getting-started/linux/ \
    # https://github.com/hybridgroup/gocv/blob/e2db8f81cfce48d9b2c2d4ce92219a7a4a021bfe/Makefile#L21
    && apt-get install -y unzip build-essential cmake curl git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev \
    libswscale-dev libtbbmalloc2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-dev
# install opencv
RUN mkdir /gocv \
    && cd /gocv \
    && go mod init test \
    && go get gocv.io/x/gocv@v0.35.0 \
    && cd /go/pkg/mod/gocv.io/x/gocv@v0.35.0 \
    && make download \
    && make build \
    && cd /tmp/opencv/opencv-4.8.1/build \
    && make install \
    && ldconfig \
    && cd /go/pkg/mod/gocv.io/x/gocv@v0.35.0 \
    && go run ./cmd/version/main.go \
    && rm -rf /gocv