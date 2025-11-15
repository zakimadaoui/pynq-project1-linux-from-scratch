#!/bin/bash
INITRAMFS_DIR=artifacts/initramfs/
rm ${INITRAMFS_DIR} -rf
mkdir -p ${INITRAMFS_DIR}/{bin,sbin,etc/init.d,proc,sys,usr/{bin,sbin},dev}

# copy startup script
cp rcS ${INITRAMFS_DIR}/etc/init.d/rcS
chmod a+x ${INITRAMFS_DIR}/etc/init.d/rcS