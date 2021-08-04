#! /bin/bash

echo "User name: "
read user

echo "Password: "
read password

useradd $user -s /usr/sbin/nologin -g sftp-users -m && \
echo $user:$password | chpasswd && \