# Building and booting linux from scratch on Pynq-z2

# TODO:

[ ] add 'all' Makefile target and correct dependencies for other targets

[ ] you can build bootgen locally to avoid having it as an external user dependency: https://github.com/Xilinx/bootgen

[ ] You can download xsct tarball and use it directly instead of having a dependency on xilinx innate installation 

This is an educational project and documentation for my future self and anyone else interested in learning the following
## Learning objectives 
- Learn about the xilinx zynq 7000 SoC boot process
- patch, configure and compile:
  - Xilinx first stage boot loader (FSBL)
  - U-boot 
  - Linux kernel 
  - Device tree for pynq-z2
  - busybox
  - create a simple initramfs
- Create a bootable image for zynq 7000 SoC/pynq-z2 board which gives access to u-boot
- use u-boot to load linux kernel, device tree and rootfs and boot to linux 
- simple statup script to setup /dev and start a shell

## General steps for booting linux from scratch
-  Build FSBL
-  Build U-boot 
-  Generate device tree source from hardware design and then compile it to get a device tree blob
-  Build the linux kernel
-  Create a boot image using bootgen or zynq-mkbootimage (opensource from antmicro) 
-  Create and packge a root filesystem populated with busybox and startup script
-  Prepare the boot medium. In my case SDCARD with msdos partition table and a FAT32 partition that has boot flag and copy the boot files into it

The above steps can be performed with (see dependencies section first):
```Bash
# one shot
make all
# module-wise
make fsbl
make uboot
make dtb 
make kernel
make bootgen
make rootfs

```

## Dependencies:
Tested with Ubuntu 24.04
```bash
sudo apt install gcc-arm-linux-gnueabihf # and dependencies
sudo apt install gcc-arm-none-eabi-gcc # and dependencies
sudo apt install bison flex openssl libssl-dev 
sudo apt-get install uuid-dev libgnutls28-dev 
sudo apt install pkg-config meson ninja-build # needed for building dtc


```

## Resources 
Git repos, see: 
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842156/Fetch+Sources

Link                                         | Content
---------------------------------------------------------|----------------------------------------------
https://github.com/Xilinx/linux-xlnx.git                 | The Linux kernel with Xilinx patches and drivers
https://github.com/Xilinx/u-boot-xlnx.git                | The u-boot bootloader with Xilinx patches and drivers
https://github.com/Xilinx/device-tree-xlnx.git           | Device Tree generator plugin for xsdk
https://git.kernel.org/pub/scm/utils/dtc/dtc.git         | Device Tree compiler (required to build U-Boot)
https://github.com/Xilinx/embeddedsw.git                 | Xilinx embeddedsw repository for bare-metal applications such as FSBL, PMU Firmware, PLM
https://pynq.readthedocs.io/en/v2.7.0/overlay_design_methodology/board_settings.html | Link to Pynq Z1 and Z2 Vivado board files  


### pynq-z2 board support in vivado
C:\Xilinx\Vivado\2021.2\data\boards
Where C:\Xilinx is the default path where Vivado is installed
Add a new folder and name it ‘board_files’
Download Pynq board files from this link
https://pynq.readthedocs.io/en/v2.7.0/overlay_design_methodology/board_settings.html
Extract board files then copy them to ‘board_files’ folder
Restart Vivado


https://www.youtube.com/watch?v=3D2-OPArCiA&list=PLAIW2DtZ4NI77mo2qFhvZKGZ1n1W8vWYY&index=16


###  FSBL manual build instructions:
- https://github.com/Xilinx/embeddedsw/blob/master/lib/sw_apps/zynq_fsbl/misc/Readme.txt for build

### Generating and compiling the device tree:
- https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842279/Build+Device+Tree+Blob
- https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/341082130/Quick+guide+to+Debugging+Device+Tree+Generator+Issues

### building U-boot
- https://docs.u-boot.org/en/latest/board/xilinx/zynq.html
- https://github.com/Xilinx/u-boot-xlnx 

### Creating the SD card

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842385/How+to+format+SD+card+for+SD+boot


## QEMU
To test u-boot

```bash
qemu-system-arm \
  -M xilinx-zynq-a9 \
  -m 1024M \
  -serial mon:stdio \
  -serial null \
  -kernel artifacts/u-boot.elf 
  -nographic
  # -sd sdcardfile 
```

Or to boot a Linux kernel:

```bash
qemu-system-arm \
  -M xilinx-zynq-a9 \
  -m 512M \
  -serial mon:stdio \
  -kernel artifacts/uImage \
  -initrd artifacts/initramfs.cpio.gz \
  -dtb artifacts/system.dtb \
  -append "console=ttyPS0,115200 earlyprintk"
  -nographic
```