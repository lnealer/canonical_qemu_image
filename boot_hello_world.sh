#!/bin/sh

sudo apt update
sudo apt install --yes cloud-image-utils qemu-system-x86

# Download and unzip image
curl -O http://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img 

# create the image
cloud-localds hello-world-seed.img user-data.yaml

# boot the image
sudo qemu-system-x86_64  \
  -cpu host -machine type=q35,accel=kvm -m 2048 \
  -nographic \
  -snapshot \
  -netdev id=net00,type=user,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net00 \
  -drive if=virtio,format=qcow2,file=jammy-server-cloudimg-amd64.img  \
  -drive if=virtio,format=raw,file=hello-world-seed.img \

