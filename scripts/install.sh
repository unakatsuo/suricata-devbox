#!/bin/bash

set -e

echo "Install basic tools"

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum install -y iproute lsof nmap-ncat tcpdump
