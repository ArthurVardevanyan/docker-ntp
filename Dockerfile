FROM alpine:latest

ARG BUILD_DATE

# first, a bit about this container
LABEL build_info="cturra/docker-ntp build-date:- ${BUILD_DATE}"
LABEL maintainer="Chris Turra <cturra@gmail.com>"
LABEL documentation="https://github.com/cturra/docker-ntp"

# install chrony
RUN apk add --no-cache chrony tzdata

# install chrony_exporter
ARG CHRONY_EXPORTER_VERSION=0.12.1
RUN ARCH=$(uname -m) && \
    case $ARCH in \
        x86_64) ARCH="amd64" ;; \
        aarch64) ARCH="arm64" ;; \
        armv7l) ARCH="armv7" ;; \
        armv6l) ARCH="armv6" ;; \
        ppc64le) ARCH="ppc64le" ;; \
        s390x) ARCH="s390x" ;; \
        *) echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac && \
    wget -O /tmp/chrony_exporter.tar.gz "https://github.com/superq/chrony_exporter/releases/download/v${CHRONY_EXPORTER_VERSION}/chrony_exporter-${CHRONY_EXPORTER_VERSION}.linux-${ARCH}.tar.gz" && \
    tar -xzf /tmp/chrony_exporter.tar.gz -C /tmp && \
    mv /tmp/chrony_exporter-${CHRONY_EXPORTER_VERSION}.linux-${ARCH}/chrony_exporter /usr/local/bin/ && \
    rm -rf /tmp/chrony_exporter*

# script to configure/startup chrony (ntp)
COPY assets/startup.sh /opt/startup.sh

# ntp port
EXPOSE 123/udp 9433/tcp

# let docker know how to test container health
HEALTHCHECK CMD chronyc -n tracking || exit 1

# start chronyd in the foreground
ENTRYPOINT [ "/bin/sh", "/opt/startup.sh" ]

USER 1001