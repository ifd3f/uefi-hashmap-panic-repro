#!/usr/bin/env bash

# helper script for testing in qemu

set -euxo pipefail

# set up an esp
cargo build --target x86_64-unknown-uefi
rm -rf esp
mkdir -p esp/efi/boot
cp -r target/x86_64-unknown-uefi/release/uefi-std-example.efi esp/efi/boot/bootx64.efi

# launch!
qemu-system-x86_64 \
    -D ./qemu.log \
    -drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \
    -drive if=pflash,format=raw,readonly=on,file=./OVMF_VARS.fd \
    -drive format=raw,file=fat:rw:esp