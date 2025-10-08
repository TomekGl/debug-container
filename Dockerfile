FROM alpine:3.22.1

ARG GIT_TAG

ENV RELEASE=${GIT_TAG}

LABEL maintainer="Tomasz Głuch <git@tomaszgluch.pl>"

LABEL org.opencontainers.image.title="debug-container"
LABEL org.opencontainers.image.description="Debug tools for troubleshooting container platforms"
LABEL org.opencontainers.image.version=${GIT_TAG}
LABEL org.opencontainers.image.authors="Tomasz Głuch <git@tomaszgluch.pl>"


RUN apk add --update --no-cache \
      bash \
      bind-tools \
      bmon \
      bwm-ng \
      curl \
      dumb-init \
      fish \
      gawk \
      git \
      htop \
      iperf3 \
      iproute2 \
      iproute2-ss \
      jq \
      kubectl \
      kubectl-bash-completion \
      mbuffer \
      mtr \
      nmap \
      py3-kubernetes \
      python3 \
      rclone \
      rsync \
      tcpdump \
      tshark \
      screen \
      strace \
      stress-ng \
      vim \
      wget

CMD ["/usr/bin/fish"]
