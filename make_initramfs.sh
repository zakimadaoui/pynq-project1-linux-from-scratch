#!/bin/bash 

rm artifacts/initramfs.cpio.gz -fv
cd artifacts/initramfs
find . | cpio -o -H newc --owner=0:0 | gzip  > ../initramfs.cpio.gz
mkimage -A arm -O linux -T ramdisk -C gzip -d ../initramfs.cpio.gz ../uInitrd