#!/bin/sh
set -e
if [ ! -f /etc/mqttbeat/mqttbeat.yml ]; then
  cp /etc/default/mqttbeat.yml /etc/mqttbeat/mqttbeat.yml
fi
if [ ! -f /etc/mqttbeat/fields.yml ]; then
  cp /etc/default/fields.yml /etc/mqttbeat/fields.yml
fi

exec "$@"
