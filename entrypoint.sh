#!/bin/sh
set -e
if [ ! -f /home/mqttbeat/conf/mqttbeat.conf ]; then
  cp /etc/default/mqttbeat.conf /home/mqttbeat/conf/mqttbeat.conf
fi
