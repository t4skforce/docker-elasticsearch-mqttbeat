#!/bin/sh
set -e
if [ ! -f /etc/mqttbeat/mqttbeat.conf ]; then
  cp /etc/default/mqttbeat.conf /etc/mqttbeat/mqttbeat.conf
fi
