#!/bin/bash

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p ${GO_DIR}/src

(umask 077; touch ~/.ssh/{config,known_hosts})

echo "export GOPATH=${GO_DIR}" >> ~/.bashrc
