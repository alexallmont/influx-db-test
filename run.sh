#!/bin/env bash
docker run \
    --interactive \
    --tty \
    --mount source=influx-db,target=/etc/influx-db \
    --workdir /etc/influx-db \
    influx-db-test:latest \
    bash
