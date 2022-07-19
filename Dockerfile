FROM alpine:3

RUN apk upgrade --no-cache && \
   /bin/sh -c "apk add --update --no-cache bash ca-certificates curl git jq openssh libc6-compat libgcc libstdc++ ncurses-libssudo" && \
   ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
