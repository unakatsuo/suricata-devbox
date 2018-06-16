#!/bin/bash

set -e

if ! type packer; then
  echo "packer command not found. Please install from https://packer.io/" >&2
  exit 1
fi

export HOST_SWITCH=vboxnet0
export NIC2_IPV4=${NIC2_IPV4:?Missing IPv4 address for NIC2.}

#box_url="${1:?ERROR: Require to set download .box URL}"
box_url="http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box"
box_tmp="${2:-boxtemp/7}"

# ignore duplicating dir
mkdir -p $box_tmp  || :

(
  cd $box_tmp
  if [ -f './.etag' ]; then
      etag=$(cat ./.etag)
  fi
  curl --dump-header box.header ${etag:+-H "If-None-Match: ${etag}"} -L -o "t.box" "${box_url}"
  cat box.header | awk 'BEGIN {FS=": "}/^ETag/{print $2}' > .etag
  rm -f box.header
  tar -xzf t.box

  [ -f "vagrant.key" ] || {
    curl -o vagrant.key -L "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant"
  }

)

packer build -force devbox-centos7.json
