FROM golang:alpine

ENV GOROOT /go

RUN apk add --no-cache g++ glide git && \
mkdir -p /go/src/github.com/nathan-k-/ && \
cd /go/src/github.com/nathan-k-/ && \
git clone https://github.com/nathan-k-/mqttbeat && \
cd ./mqttbeat && \
glide install && \
go build -o mqttbeat && \
cp ./mqttbeat /usr/bin/ && \
mkdir -p /etc/mqttbeat/ && \
apk del g++ glide && rm -rf $GOPATH && \
addgroup -g 1000 -S mqttbeat && adduser -u 1000 -S mqttbeat -G mqttbeat && \
mkdir -p /etc/mqttbeat && \
chown -R mqttbeat:mqttbeat /etc/mqttbeat

ADD ./mqttbeat.yml /etc/default/mqttbeat.yml
ADD ./entrypoint.sh /home/mqttbeat/entrypoint.sh
RUN chmod +x /home/mqttbeat/entrypoint.sh && \
chown mqttbeat:mqttbeat /home/mqttbeat/entrypoint.sh

USER mqttbeat
WORKDIR /home/mqttbeat/
VOLUME ["/etc/mqttbeat"]
ENTRYPOINT ["entrypoint.sh"]
CMD ["mqttbeat", "-c", "/etc/mqttbeat/mqttbeat.yml"]
