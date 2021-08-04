#! /bin/bash

echo "User name: "
read user

echo "Password: "
read password

useradd $user -s /usr/sbin/nologin -g sftp-users -m && \
echo $user:$password | chpasswd && \
chmod 700 /home/$user && setfacl -dRm u::7,g::0,o::0 /home/$user && mkdir -p /home/$user/$user-files && \
chown -R $user:sftp-users /home/$user/$user-files/ && setfacl -dRm u::7,g::0,o::0 /home/$user/$user-files && \
chown root /home/$user/ && chmod 755 /home/$user