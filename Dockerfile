FROM ubuntu:jammy

RUN apt-get update -y
RUN apt-get upgrade -y

# Minimal build tools
RUN apt-get install -y \
    systemctl \
    influxdb \
    influxdb-client \
    g++ \
    cmake \
    libcurl4-openssl-dev \
    libboost-all-dev \
    libssl-dev

# General admin/user tools
RUN apt-get install -y \
    git \
    vim

# Build and install cpr prerequesite for influx-cpp
WORKDIR /tmp/docker-build
RUN git clone https://github.com/libcpr/cpr.git
WORKDIR cpr
RUN mkdir build
WORKDIR build
RUN cmake .. -DCPR_USE_SYSTEM_CURL=ON
RUN cmake --build .
RUN cmake --install .

# Build influx-cpp libs
WORKDIR /tmp/docker-build
RUN git clone https://github.com/offa/influxdb-cxx
WORKDIR influxdb-cxx
RUN mkdir build
WORKDIR build
RUN cmake -D INFLUXCXX_TESTING:BOOL=OFF ..
RUN make install

# Ensure that build .so is in lib path so influx-cxx libs can find cpr
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib"

# Dynamically load entrypoint for starting influxdb service
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
