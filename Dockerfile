FROM alpine:3.10

RUN ["/bin/sh", "-c", "apk add --update --no-cache bash ca-certificates curl git jq openssh libc6-compat"]

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]