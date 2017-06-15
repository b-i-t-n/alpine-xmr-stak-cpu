FROM  alpine:latest
COPY start.sh /tmp/
COPY config.txt /tmp/
RUN   adduser -S -D -H -h /xmr-stak-cpu/bin miner
RUN   chown miner /tmp/config.txt
RUN   apk --no-cache upgrade && \
  apk --no-cache add \
    openssl-dev \
    cmake \
    g++ \
    build-base \
    git && \
  git clone https://github.com/b-i-t-n/xmr-stak-cpu && \
  cd xmr-stak-cpu && \
  cmake -DMICROHTTPD_REQUIRED=OFF -DCMAKE_LINK_STATIC=ON . && \
  make && \
  apk del \
    cmake \
    g++ \
    build-base \
    git
WORKDIR		/tmp
USER miner
ENTRYPOINT	["./start.sh"]
