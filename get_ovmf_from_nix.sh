#!/usr/bin/env bash

set -euxo pipefail

ovmfdir=$(nix build .#ovmf.fd --print-out-paths --no-link)
rm -f *.fd
cp $ovmfdir/FV/* .
chmod +rw *.fd
