FROM golang:alpine

RUN apk add --no-cache g++ glide \
mkdir -p /go/src/github.com/nathan-k-/ && \
cd /go/src/github.com/nathan-k-/ && \
git clone https://github.com/nathan-k-/mqttbeat && \
cd ./mqttbeat && \
glide install && \
make setup && \
make && \
cp ./mqttbeat /usr/bin/ && \
mkdir -p /etc/mqttbeat/ && \
cp ./mqttbeat.full.yml /etc/default/mqttbeat.yml && \
apk del g++ glide && rm -rf $GOPATH && \
addgroup -g 1000 -S mqttbeat && adduser -u 1000 -S mqttbeat -G mqttbeat && \


USER mqttbeat
WORKDIR /home/mqttbeat
ENTRYPOINT ["./entrypoint.sh"]
CMD ["mqttbeat", "-c", "./mqttbeat.yml", "-e", "-d", "*"]
