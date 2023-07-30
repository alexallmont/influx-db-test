#!/bin/env bash
docker run \
    --interactive \
    --tty \
    --mount source=foo,target=/etc/influx-db \
    --workdir /etc/influx-db \
    influx-db-test:latest \
    bash
