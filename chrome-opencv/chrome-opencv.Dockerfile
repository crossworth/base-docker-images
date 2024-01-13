FROM debian:bookworm-slim
# define the home env variable for x11vnc
ENV HOME=/
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    # needed for virtual display, install chrome, vnc
    && apt-get install -y wget unzip gnupg xvfb x11vnc \
    # opencv runtime
    && apt-get install -y libgtk2.0-dev libavcodec-dev libavformat-dev  \
    libswscale-dev libtbbmalloc2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-dev \
    # install chrome
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -  \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y --fix-missing google-chrome-stable \
    && apt-get install -y tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*