#!/bin/sh
systemctl start influxdb

exec "$@"
