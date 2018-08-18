#!/bin/sh
set -e
if [ ! -f /etc/mqttbeat/mqttbeat.yml ]; then
  cp /etc/default/mqttbeat.yml /etc/mqttbeat/mqttbeat.yml
fi
