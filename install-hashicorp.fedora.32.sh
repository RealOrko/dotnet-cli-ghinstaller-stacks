#!/usr/bin/env bash

set -ex
set -o pipefail

rm -rf ./build
mkdir -p ./build/
cd ./build/

# Install terraform
ghi download-release -o hashicorp -r terraform -f v0.11.14 -t
ghi untar -t ./v0.11.14.tar -o ./v0.11.14
ghi build-go -a get -d ./v0.11.14/hashicorp-terraform-c81dc0a/ || true
cd ./v0.11.14/hashicorp-terraform-c81dc0a/
go mod vendor
cd ../../
ghi build-go -d ./v0.11.14/hashicorp-terraform-c81dc0a/ -o $(pwd)/terraform
ghi install -b ./terraform
echo "terraform installed successfully ... "

# Install packer
ghi download-release -o hashicorp -r packer -f v1.5.6 -t
ghi untar -t ./v1.5.6.tar -o ./v1.5.6
ghi build-go -a get -d ./v1.5.6/hashicorp-packer-9ac6efc/ || true
ghi build-go -d ./v1.5.6/hashicorp-packer-9ac6efc/ -o $(pwd)/packer
ghi install -b ./packer
echo "packer installed successfully ... "

# Install vault 
ghi download-tag -o hashicorp -r vault -f v1.4.2 -t
ghi untar -t ./v1.4.2.tar -o ./v1.4.2
ghi build-go -a get -d ./v1.4.2/hashicorp-vault-d6b3c72/ || true
ghi build-go -d ./v1.4.2/hashicorp-vault-d6b3c72/ -o $(pwd)/vault
ghi install -b ./vault

# Install nomad
ghi download-tag -o hashicorp -r nomad -f v0.11.2 -t
ghi untar -t ./v0.11.2.tar -o ./v0.11.2
ghi build-go -a get -d ./v0.11.2/hashicorp-nomad-d6b3c72/ || true
ghi build-go -d ./v0.11.2/hashicorp-nomad-d6b3c72/ -o $(pwd)/nomad
ghi install -b ./nomad
