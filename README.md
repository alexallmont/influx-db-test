# Docker environment for testing influx-db with C++

Built referencing tutorial at https://www.influxdata.com/blog/getting-started-c-influxdb/

## Build notes

Currently requires manual creation of volume 'influx-db' persist build:
    docker volume create influx-db

Files main.cpp and CMakeLists.txt need to be docker copied to volume

Build and run with respective .sh scripts
