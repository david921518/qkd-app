# 虚拟机系统实例（VMOS）

## 自述 (README)

| 语言 | 链接 |
|------|------|
| 中文 | [html](./index.html) [md](./README.md) |
| 英文 (English) | [html](./index.en.html) [md](./README.en.md) |
| 西班牙文 (Español) | [html](./index.es.html) [md](./README.es.md) |

## 仿真说明

本目录包含了在宿主系统环境 **Windows 10/x86_64** 中构建目标机器 **Q35/x86_64** 上可运行的 **Windows 10** 访客操作系统

### 安装步骤

本文假设你已经将【乾坤袋虚拟系统】安装到了 **C:\qkd-app** 目录中

#### 开启 Windows Hyper-V

确认主机 Windows 10 系统已经安装并开启了 Hyper-V 支持

访问 [下载 Windows 10](https://www.microsoft.com/zh-Cn/software-download/windows10) 获取最新版本 Windows 10 的安装镜像，保存为 orig_win10.iso

#### 安装 QEMU 9.0

访问 [QEMU for Windows – Installers (64 bit)](https://qemu.weilnetz.de/w64/) 并下载 [QEMU 9.0.0](https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe)

将 QEMU 9.0.0 安装到 **C:\qkd-app\qemu\9.0.0** 目录下

#### 获取 virtio ISO

访问 [稳定版 virtio](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.262-2/)  并下载 [virtio-win-0.1.262.iso](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.262-2/virtio-win-0.1.262.iso)

虚拟机中的 SCSI 磁盘支持需要这些驱动

#### 创建虚拟盘

在 QEMU 9.0.0 的安装目录 **C:\qkd-app\qemu\9.0.0** 中执行以下命令

```
qemu-img create -f qcow2 win10-chs.qcow2 60G
```

#### 生成 EFI 固件合并文件

在命令提示符窗口执行以下命令


```
cd /d C:\qkd-app\qemu\9.0.0\share
copy /B edk2-i386-vars.fd + edk2-x86_64-code.fd edk2-x86_64.fd
```

我们将使用新生成的 edk2-x86_64.fd EFI 固件文件来启动 Windows 10 安装盘

#### 启动安装盘

使用以下命令启动 Windows 10 安装盘并完成安装

```
qemu-system-x86_64 -accel tcg -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35 -smp 4 -device qxl-vga,vgamem_mb=64 -audiodev sdl,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -device ich9-ahci,id=ahci -device ide-cd,drive=cd0,bus=ahci.0,bootindex=0 -device ide-cd,drive=cd1,bus=ahci.1 -drive file=orig_win10.iso,if=none,media=cdrom,readonly=on,id=cd0 -drive file=virtio-win-0.1.262.iso,if=none,media=cdrom,readonly=on,id=cd1 -no-reboot
```

#### 安装 virtio 驱动

使用以下命令启动 Windows 10 新系统并完成 virtio 驱动安装

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display gtk,gl=off,show-cursor=on -device virtio-vga,xres=1280,yres=720 -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -device ich9-ahci,id=ahci -device ide-cd,drive=cd0,bus=ahci.0,bootindex=0 -device ide-cd,drive=cd1,bus=ahci.1 -drive file=orig_win10.iso,if=none,media=cdrom,readonly=on,id=cd0 -drive file=virtio-win-0.1.262.iso,if=none,media=cdrom,readonly=on,id=cd1 -object memory-backend-ram,id=ram0,size=8G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

选择 virtio ISO 中的 viogpudo\ 目录，安装 VirtIO GPU DOD 显卡驱动

选择 virtio ISO 中的 NetKVM\ 目录，安装 VirtIO Ethernet Adapter 网卡驱动

另外，可以同步安装 virtio ISO 根目录下的 Virtio-win-guest-tools 工具

#### 启动新系统

KPCOS 定制系统默认使用 GTK 显示，不支持 OpenGL 3D 模式，使用以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display gtk,gl=off,show-cursor=on -device virtio-vga,xres=1280,yres=720 -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -object memory-backend-ram,id=ram0,size=8G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

如果需要支持 OpenGL 3D 模式，需要使用 SDL 显示，通过以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display sdl,gl=on,show-cursor=on -device virtio-vga-gl,xres=1280,yres=720 -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -object memory-backend-ram,id=ram0,size=8G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

乾坤袋虚拟系统默认使用 [网页 VNC](../../../../vnc/index.html) 显示虚拟机的显示器输出，通过以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display none -device virtio-vga,xres=1280,yres=720 -vnc localhost:50000,websocket=on -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=8G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

#### 配置网络

乾坤袋虚拟系统通过以下命令启动新系统

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 8192 -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display none -device virtio-vga,xres=1280,yres=720 -vnc localhost:50000,websocket=on -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=win10-chs.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=8G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

默认系统自动获取 10.0.2.15 的 IPv4 地址，使用 10.0.2.3 作为 DNS 服务器地址

当 QEMU 自带的 DNS 服务器不能正常工作时，可以修改网络适配器的IPv4协议属性，设置使用下面的 DNS 服务器地址

首选 DNS 服务器： 8.8.8.8
备用 DNS 服务器： 8.8.4.4

## 参考资料

1. [Running Windows 11 at near-native speed in QEMU on Windows to have sensitive data encrypted](https://windowsforum.com/threads/running-windows-11-at-near-native-speed-in-qemu-on-windows-to-have-sensitive-data-encrypted.339034/)
2. [Running Android games on Windows 10/11 using QEMU+Hyper-V+virglrenderer+Bliss OS](https://guanzhang.medium.com/running-android-games-on-windows-10-11-4eea9be9a06b)