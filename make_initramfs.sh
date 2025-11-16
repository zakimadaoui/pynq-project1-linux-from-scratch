#!/bin/bash 

rm artifacts/initramfs.cpio.gz -fv
cd artifacts/initramfs
find . | cpio -o -H newc --owner=0:0 | gzip  > ../initramfs.cpio.gz
cd -
./uboot_src/tools/mkimage -A arm -O linux -T ramdisk -C gzip -d artifacts/initramfs.cpio.gz artifacts/uInitrd