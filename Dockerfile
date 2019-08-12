FROM phusion/baseimage:0.11

ENV num_threads 2
ENV gr_branch maint-3.8

RUN apt-get update && apt-get dist-upgrade -yf && apt-get clean && apt-get autoremove
RUN apt-get install -y \
        build-essential \
        cmake \
        dbus-x11 \
        doxygen \
        git \
        libasound2-dev \
        liblog4cpp5-dev \
        libboost-all-dev \
        libcodec2-dev \
        libcomedi-dev \
        libfftw3-dev \
        libgmp-dev \
        libgsl-dev \
        libgtk-3-dev \
        liblog4cpp5-dev \
        libqwt-qt5-dev \
        libqt5opengl5-dev \
        libsdl1.2-dev \
        libuhd-dev \
        libusb-1.0-0 \
        libusb-1.0-0-dev \
        libzmq3-dev \
        pkg-config \
        python3-click \
        python3-click-plugins \
        python3-gi-cairo \
        python3-lxml \
        python3-mako \
        python3-numpy \
        python3-pyqt5 \
        python3-setuptools \
        python3-sphinx \
        python3-yaml \
        swig \
        uhd-host

WORKDIR /opt/
RUN git clone --recursive https://github.com/gnuradio/gnuradio.git
WORKDIR /opt/gnuradio
RUN git checkout ${gr_branch}
RUN mkdir build && cd build
WORKDIR /opt/gnuradio/build
RUN cmake ../
RUN make -j${num_threads}
RUN make install
RUN ldconfig

CMD ["/bin/bash"]
