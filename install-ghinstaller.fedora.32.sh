#!/usr/bin/env bash

set -ex
set -o pipefail

dotnet tool uninstall -g dotnet-cli-ghinstaller || true
dotnet tool install --no-cache -g dotnet-cli-ghinstaller || true
