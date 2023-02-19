#!/bin/bash
  echo "export IP=$IP"
  echo "export HOSTNAME=$HOSTNAME"
  sleep 5;

  curl https://releases.rancher.com/install-docker/19.03.sh | sh
  usermod -aG docker service
  apt-get install git -y
  curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

cat <<EOF >/etc/network/interfaces
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

auto enp3s0
iface enp3s0 inet static
  address $IP
  netmask 255.255.255.0
  gateway 192.168.100.1
  dns-nameservers 192.168.100.150
EOF

hostnamectl set-hostname $HOSTNAME
