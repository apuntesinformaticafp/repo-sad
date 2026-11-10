FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        coreutils \
        git \
        grep \
        iproute2 \
        openssl \
        sed \
        tar \
    && rm -rf /var/lib/apt/lists/*
