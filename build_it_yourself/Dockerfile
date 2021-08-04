FROM debian:stable-slim

LABEL author Cimlah

RUN \
apt update && \
apt upgrade -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw
RUN apt install -y tzdata openssh-server openssh-sftp-server acl