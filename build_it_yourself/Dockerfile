FROM debian:stable-slim

LABEL author Cimlah

RUN \
apt update && \
apt upgrade -y
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw
RUN apt install -y tzdata openssh-server openssh-sftp-server acl && \
groupadd sftp-users
COPY entrypoint.sh /
COPY user_add.sh /usr/local/bin/
RUN rm /etc/ssh/sshd_config && mv /usr/local/bin/user_add.sh /usr/local/bin/user_add && chmod 755 /usr/local/bin/user_add
COPY sshd_config /etc/ssh/
WORKDIR /
CMD entrypoint.sh
EXPOSE 22