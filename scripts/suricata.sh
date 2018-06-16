#!/bin/bash

set -e

curl -o /etc/yum.repos.d/jasonish-suricata-stable-epel-7.repo https://copr.fedorainfracloud.org/coprs/jasonish/suricata-stable/repo/epel-7/jasonish-suricata-stable-epel-7.repo
yum install -y suricata
