#!/bin/bash

# Generate SSH Keys
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
ssh-keygen -f  /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521
ssh-keygen -f  /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

# Disable DNS cause it is annoying and pointless
sed -i 's/#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config

# Enable password authentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

pip install supervisor

cat <<EOF > /etc/supervisord.conf
[supervisord]
nodaemon=true
pidfile = /run/supervisord.pid
# It seems that it's not possible to swith this log to NONE (it creates NONE logfile)
logfile = /dev/null
# Set loglevel=debug, only then all logs from child services are printed out
loglevel = debug

[program:sshd]
command=/usr/sbin/sshd -D
EOF
