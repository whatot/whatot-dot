#!/bin/bash
set -exu

sudo apt update
sudo apt install docker docker-compose git vim openssh-server
sudo usermod -aG docker "$(whoami)"

git clone https://github.com/pingcap/tidb-docker-compose.git

# mysql -h 192.168.122.5 -P 4000 -u root
