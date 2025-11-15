# TODO:
[x] add 'all' Makefile target and correct dependencies for other targets
[x] general cleanup, clear make target for optee, and git commit
[ ] resolve todos in linux patch for optee. They will be quite a nice exercise
[z] install linux tee suplicant and play with it
[z] add trusted applications
[ ] TODO: add a way to downlod the arm gcc toolchain and copy thesese from there ...
[ ] build and add a custom rust trustlet
[ ] secure boot image and try to create a flow with xsct
[ ] boot second CPU... now i think we are booting only from one. I can't see any cpu nodes in /dev/cpu*...

[-] update readme.... :)
    - architecture of trust zone boot/flow
    - memory map of boot images
[ ] uboot relocates the device tree somewhere else where it shouldn't... we need to correct that before it overrites optee....
[ ] you can build bootgen locally to avoid having it as an external user dependency: https://github.com/Xilinx/bootgen
[ ] You can download xsct tarball and use it directly instead of having a dependency on xilinx innate installation 
[ ] todo: update the resources sections with optee info...

