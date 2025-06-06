# 虚拟机系统实例（VMOS）

## 自述 (README)

| 语言 | 链接 |
|------|------|
| 中文 | [html](./index.html) [md](./README.md) |
| 英文 (English) | [html](./index.en.html) [md](./README.en.md) |
| 西班牙文 (Español) | [html](./index.es.html) [md](./README.es.md) |

## 仿真说明

本目录包含了在宿主系统环境 **Windows 10/x86_64** 中构建目标机器 **Q35/x86_64** 上可运行的 **Debian 12** 访客操作系统

### 安装步骤

本文假设你已经将【乾坤袋虚拟系统】安装到了 **C:\qkd-app** 目录中

#### 开启 Windows Hyper-V

确认主机 Windows 10 系统已经安装并开启了 Hyper-V 支持

访问 [本地 QEMU 虚拟机 64 位 AMD/Intel (qcow2)](https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2) 获取最新版本 Debian 12 的安装镜像，保存为 debian-12-nocloud-amd64.qcow2

#### 安装 QEMU 9.0

访问 [QEMU for Windows – Installers (64 bit)](https://qemu.weilnetz.de/w64/) 并下载 [QEMU 9.0.0](https://qemu.weilnetz.de/w64/qemu-w64-setup-20240423.exe)

将 QEMU 9.0.0 安装到 **C:\qkd-app\qemu\9.0.0** 目录下

#### 创建虚拟盘

将下载的 debian-12-nocloud-amd64.qcow2 安装镜像复制到 QEMU 9.0.0 的安装目录 **C:\qkd-app\qemu\9.0.0** 中，此文件是 qcow2 格式的镜像文件。

在 QEMU 9.0.0 的安装目录 **C:\qkd-app\qemu\9.0.0** 中执行以下命令

```
qemu-img info debian-12-nocloud-amd64.qcow2
```

查看原始镜像文件的信息，输出信息如下：

```
image: debian-12-nocloud-amd64.qcow2
file format: qcow2
virtual size: 2 GiB (2147483648 bytes)
disk size: 396 MiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    compression type: zlib
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
    extended l2: false
Child node '/file':
    filename: debian-12-nocloud-amd64.qcow2
    protocol type: file
    file length: 396 MiB (415646720 bytes)
    disk size: 396 MiB
```

#### 扩容启动镜像

Debian 官方提供的启动镜像只有 2G 容量，我们将为其扩容至 40G 容量

在命令提示符窗口执行以下命令

```
qemu-img resize debian-12-nocloud-amd64.qcow2 40G
```

使用以下命令检查镜像文件是否按要求修改为 40G 容量

```
qemu-img info debian-12-nocloud-amd64.qcow2
```

输出信息如下

```
image: debian-12-nocloud-amd64.qcow2
file format: qcow2
virtual size: 40 GiB (42949672960 bytes)
disk size: 396 MiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    compression type: zlib
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
    extended l2: false
Child node '/file':
    filename: debian-12-nocloud-amd64.qcow2
    protocol type: file
    file length: 396 MiB (415695872 bytes)
    disk size: 396 MiB
```

#### 生成 EFI 固件合并文件

在命令提示符窗口执行以下命令


```
cd /d C:\qkd-app\qemu\9.0.0\share
copy /B edk2-i386-vars.fd + edk2-x86_64-code.fd edk2-x86_64.fd
```

我们将使用新生成的 edk2-x86_64.fd EFI 固件文件来启动 Debian 12

#### 启动新系统

KPCOS 定制系统默认使用 GTK 显示，不支持 OpenGL 3D 模式，使用以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 4G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display gtk,gl=off,show-cursor=on -vga qxl -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=debian-12-nocloud-amd64.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -object memory-backend-ram,id=ram0,size=4G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

乾坤袋虚拟系统默认使用 [网页 VNC](../../../../vnc/index.html) 显示虚拟机的显示器输出，通过以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 4G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display none -vga qxl -vnc localhost:50000,websocket=on -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=debian-12-nocloud-amd64.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=4G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

#### 配置网络

乾坤袋虚拟系统通过以下命令启动新系统

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 4G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 4 -display none -vga qxl -vnc localhost:50000,websocket=on -netdev user,id=hn0 -device virtio-net-pci,netdev=hn0,id=nic1,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=debian-12-nocloud-amd64.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=4G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

默认系统自动获取 10.0.2.15 的 IPv4 地址，使用 10.0.2.3 作为 DNS 服务器地址

当 QEMU 自带的 DNS 服务器不能正常工作时，可以修改网络适配器的IPv4协议属性，设置使用下面的 DNS 服务器地址

首选 DNS 服务器： 8.8.8.8
备用 DNS 服务器： 8.8.4.4

### 分区扩容

首先安装扩容需要的工具，在 Debian 12 中执行以下命令

```
apt-get update
apt-get install parted
```

查看当前块设备信息，执行以下命令

```
lsblk
```

输出结果如下：

```
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0   40G  0 disk 
├─sda1    8:1    0  1.9G  0 part /
├─sda14   8:14   0    3M  0 part 
└─sda15   8:15   0  124M  0 part /boot/efi
```

可以看到 sda 磁盘大小是 40G，但是目前系统只使用了 sda1(1.9G) 和 sda15(124M) 共 2G 的空间

我们将对 sda1 分区扩容，把剩余的未使用空间都分给 sda1，操作如下

```
loop_device=$(losetup -f)
losetup $loop_device /dev/sda
```

将磁盘挂载到本地环回设备后，我们对本地环回设备操作就相当于对磁盘的操作

修改 sda1 分区，令其使用所有剩余磁盘空间，命令如下

```
echo -e "Fix" | parted ---pretend-input-tty "$loop_device" print
parted "$loop_device" resizepart 1 100%
parted "$loop_device" print
```

修改分区前，sda 块设备信息如下

```
Model: Loopback device (loopback)
Disk /dev/loop0: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  4194kB  3146kB                     bios_grub
15      4194kB  134MB   130MB   fat16              boot, esp
 1      134MB   2146MB  2012MB  ext4
```

修改分区后，sda 块设备信息如下

```
Model: Loopback device (loopback)                                         
Disk /dev/loop0: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  4194kB  3146kB                     bios_grub
15      4194kB  134MB   130MB   fat16              boot, esp
 1      134MB   42.9GB  42.8GB  ext4
```

完成修改后，重启系统

### 文件系统扩容

系统重启后，使用以下命令确认磁盘分区是否已经成功扩容

```
parted /dev/sda print
```

输出信息如下

```
Model: QEMU QEMU HARDDISK (scsi)
Disk /dev/sda: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  4194kB  3146kB                     bios_grub
15      4194kB  134MB   130MB   fat16              boot, esp
 1      134MB   42.9GB  42.8GB  ext4
```

确认分区已经扩容，使用以下命令查看文件系统状态

```
df -h
```

输出信息如下

```
Filesystem      Size  Used Avail Use% Mounted on
udev            1.9G     0  1.9G   0% /dev
tmpfs           391M  596K  391M   1% /run
/dev/sda1        40G  1.2G   37G   4% /
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sda15      124M   12M  113M  10% /boot/efi
```

需要将文件系统扩容到整个分区，使用以下命令

```
loop_device=$(losetup -f)
losetup $loop_device /dev/sda1
resize2fs -f $loop_device
```

完成后重启系统，使用以下命令确认是否扩容成功

```
df -h
```

输出信息如下

```
Filesystem                Size      Used Available Use% Mounted on
/dev/root                39.5G     20.6M     39.4G   0% /
tmpfs                   993.5M     60.0K    993.4M   0% /tmp
/dev/sda1                16.0M      6.1M      9.8M  38% /boot
/dev/sda1                16.0M      6.1M      9.8M  38% /boot
tmpfs                   512.0K         0    512.0K   0% /dev
```

### 配置本地网络哦访问

首先安装 SSH server 包，执行以下命令

```
apt-get install dropbear dropbear-bin
apt-get install openssh-sftp-server
```

修改 dropbear 访问端口号为 50022，将以下内容添加到 /etc/config/dropbear 文件中

```
# The TCP port that Dropbear listens on
DROPBEAR_PORT=50022
```

完成后，重启 dropbear 服务

```
/etc/init.d/dropbear restart
```

安装 netstat 命令软件包

```
apt-get install net-tools
```

使用以下命令查看网络端口状况

```
netstat -anpt |grep 50022
```

输出信息如下

```
tcp        0      0 0.0.0.0:50022           0.0.0.0:*               LISTEN      576/dropbear        
tcp6       0      0 :::50022                :::*                    LISTEN      576/dropbear        
```

可见 dropbear 已经在 50022 上监听连接，此时我们可以从 Windows 主机用 SSH 客户端连接 Debian 12

### 安装 gnome 桌面环境

Debian 12 中已经定义了 gnome 桌面的安装任务，直接安装即可

```
apt-get install -y task-gnome-desktop
```

### 创建普通用户 qkd

完成 gnome 桌面环境的安装后，需要添加一个普通用户作为日常账号，在控制台输入以下命令

```
adduser qkd
```

密码设置为 **qkd123**

将 qkd 加入所需的工作组中

```
adduser qkd sudo
adduser qkd adm
adduser qkd cdrom
adduser qkd plugdev
adduser qkd lpadmin
adduser qkd dip
```

### 增加声卡设备

添加 Intel HDA 声卡

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 4G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display gtk,gl=off,show-cursor=on -vga qxl -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -audiodev dsound,id=audio0 -device intel-hda -device hda-output,audiodev=audio0 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=debian-12-nocloud-amd64.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -object memory-backend-ram,id=ram0,size=4G,prealloc=on,share=on,merge=off,dump=off -no-reboot
```

### 中文化

选择[铜豌豆中文化-一键安装](https://www.atzlinux.com/yjaz-v12.htm)

```
apt-get update
apt-get install wget

wget https://www.atzlinux.com/atzlinux/download/install-all-single-script-v12.sh
```

执行安装

```
source install-all-single-script-v12.sh
```

重新配置本地化选项，运行命令

```
dpkg-reconfigure locales
```

选择

```
zh_CN.UTF-8
```

### 创建 swap 文件

在 Debian 12 终端执行以下命令

```
dd if=/dev/zero of=/swapfile.img bs=1M count=4096
chmod 600 /swapfile.img
mkswap /swapfile.img
swapon /swapfile.img

swapon -s
```

如果需要每次重启自动加载 swap 文件，需要在 /etc/fstab 文件中加入以下内容

```
/swapfile.img swap swap defaults 0 0
```


## 参考资料

1. [Running Windows 11 at near-native speed in QEMU on Windows to have sensitive data encrypted](https://windowsforum.com/threads/running-windows-11-at-near-native-speed-in-qemu-on-windows-to-have-sensitive-data-encrypted.339034/)
2. [Running Android games on Windows 10/11 using QEMU+Hyper-V+virglrenderer+Bliss OS](https://guanzhang.medium.com/running-android-games-on-windows-10-11-4eea9be9a06b)