#!/usr/bin/env bash

set -ex
set -o pipefail

rm -rf ./build
mkdir -p ./build/
cd ./build/

# Install the bosh-bootloader
ghi download-release -o cloudfoundry -r bosh-bootloader -f v8.4.0 -a -af linux
mv ./bbl-v8.4.0_linux_x86-64 ./bbl
chmod u+x ./bbl
ghi install -b ./bbl
echo "bbl installed successfully ... "

# Install bosh-cli
ghi download-release -o cloudfoundry -r bosh-cli -f v6.2.1 -a -af linux
mv ./bosh-cli-6.2.1-linux-amd64 ./bosh
chmod u+x ./bosh
ghi install -b ./bosh
echo "bosh installed successfully ... "

# Install credhub-cli
ghi download-release -o cloudfoundry-incubator -r credhub-cli -f 2.7.0 -t
ghi untar -t ./2.7.0.tar -o ./2.7.0
ghi build-go -a get -d ./2.7.0/cloudfoundry-incubator-credhub-cli-4ba6e6a/ || true
ghi build-go -d ./2.7.0/cloudfoundry-incubator-credhub-cli-4ba6e6a/ -o $(pwd)/credhub
ghi install -b ./credhub
echo "credhub installed successfully ... "

# Install the cloudfoundry cli
ghi download-release -o cloudfoundry -r cli -f v6.51.0 -t
ghi untar -t ./v6.51.0.tar -o ./v6.51.0
ghi build-go -a get -d ./v6.51.0/cloudfoundry-cli-2acd156/ > /dev/null || true
ghi build-go -d ./v6.51.0/cloudfoundry-cli-2acd156/ -o $(pwd)/cf
ghi install -b ./cf
echo "cf installed successfully ... "
