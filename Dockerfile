FROM golang:alpine

RUN apk add --no-cache g++ glide git && \
mkdir -p /go/src/github.com/nathan-k-/ && \
cd /go/src/github.com/nathan-k-/ && \
git clone https://github.com/nathan-k-/mqttbeat && \
cd ./mqttbeat && \
glide install && \
go build -ldflags "-linkmode external -extldflags -static" -a main.go && \
cp ./main /usr/bin/mqttbeat && \
mkdir -p /etc/default/ && \
cp ./fields.yml /etc/default/fields.yml && \
cp ./mqttbeat.yml /etc/default/mqttbeat.yml && \
apk del g++ glide git && rm -rf /go && rm -rf /root/.glide && \
addgroup -g 1000 -S mqttbeat && adduser -u 1000 -S mqttbeat -G mqttbeat && \
mkdir -p /etc/mqttbeat && \
chown -R mqttbeat:mqttbeat /etc/mqttbeat

ADD ./mqttbeat.yml /etc/default/mqttbeat.yml
ADD ./entrypoint.sh /home/mqttbeat/entrypoint.sh
RUN chmod +x /home/mqttbeat/entrypoint.sh && \
chown mqttbeat:mqttbeat /home/mqttbeat/entrypoint.sh

USER mqttbeat
WORKDIR /etc/mqttbeat/
VOLUME ["/etc/mqttbeat"]
ENTRYPOINT ["/home/mqttbeat/entrypoint.sh"]
CMD ["mqttbeat", "-c", "/etc/mqttbeat/mqttbeat.yml", "-e", "-d", "*"]
