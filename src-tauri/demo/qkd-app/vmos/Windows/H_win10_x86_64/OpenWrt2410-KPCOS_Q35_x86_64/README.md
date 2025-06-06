# 虚拟机系统实例（VMOS）

## 自述 (README)

| 语言 | 链接 |
|------|------|
| 中文 | [html](./index.html) [md](./README.md) |
| 英文 (English) | [html](./index.en.html) [md](./README.en.md) |
| 西班牙文 (Español) | [html](./index.es.html) [md](./README.es.md) |

## 仿真说明

本目录包含了在宿主系统环境 **Windows 10/x86_64** 中构建目标机器 **Q35/x86_64** 上可运行的 **OpenWrt 24.10** 访客操作系统

### 安装步骤

本文假设你已经将【乾坤袋虚拟系统】安装到了 **C:\qkd-app** 目录中

#### 开启 Windows Hyper-V

确认主机 Windows 10 系统已经安装并开启了 Hyper-V 支持

访问 [下载 COMBINED-EFI(EXT4)](https://downloads.openwrt.org/releases/24.10.0/targets/x86/64/openwrt-24.10.0-x86-64-generic-ext4-combined-efi.img.gz) 获取最新版本 OpenWrt 24.10 的安装镜像，保存为 openwrt-24.10.0-x86-64-generic-ext4-combined-efi.img.gz

#### 安装 QEMU 9.2

访问 [QEMU for Windows – Installers (64 bit)](https://qemu.weilnetz.de/w64/) 并下载 [QEMU 9.2.0](https://qemu.weilnetz.de/w64/qemu-w64-setup-20241220.exe)

将 QEMU 9.2.0 安装到 **C:\qkd-app\qemu\9.2.0** 目录下

#### 创建虚拟盘

将下载的 OpenWrt 24.10 COMBINED-EFI(EXT4) 安装镜像解压到 QEMU 9.2.0 的安装目录 **C:\qkd-app\qemu\9.2.0** 中，此文件是 raw 格式的镜像文件，我们需要将其转换成 qcow2 格式的镜像文件。

在 QEMU 9.2.0 的安装目录 **C:\qkd-app\qemu\9.2.0** 中执行以下命令

```
qemu-img convert -f raw -O qcow2 openwrt-24.10.0-x86-64-generic-ext4-combined-efi.img openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2
```

查看转换格式后获得的镜像文件

```
qemu-img info openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2
```

输出信息如下：

```
image: openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2
file format: qcow2
virtual size: 120 MiB (126123520 bytes)
disk size: 32.5 MiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    compression type: zlib
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
    extended l2: false
```

#### 扩容启动镜像

OpenWrt 官方提供的启动镜像只有 120M 容量，我们将为其扩容至 40G 容量

在命令提示符窗口执行以下命令

```
qemu-img resize openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2 40G
```

使用以下命令检查镜像文件是否按要求修改为 40G 容量

```
qemu-img info openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2
```

输出信息如下

```
image: openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2
file format: qcow2
virtual size: 40 GiB (42949672960 bytes)
disk size: 32.5 MiB
cluster_size: 65536
Format specific information:
    compat: 1.1
    compression type: zlib
    lazy refcounts: false
    refcount bits: 16
    corrupt: false
    extended l2: false
```

#### 生成 EFI 固件合并文件

在命令提示符窗口执行以下命令


```
cd /d C:\qkd-app\qemu\9.2.0\share
copy /B edk2-i386-vars.fd + edk2-x86_64-code.fd edk2-x86_64.fd
```

我们将使用新生成的 edk2-x86_64.fd EFI 固件文件来启动 OpenWrt 24.10

#### 启动新系统

KPCOS 定制系统默认使用 GTK 显示，不支持 OpenGL 3D 模式，使用以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 2G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display gtk,gl=off,show-cursor=on -vga qxl -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -object memory-backend-ram,id=ram0,size=2G,prealloc=on,share=on,merge=off -no-reboot
```

乾坤袋虚拟系统默认使用 [网页 VNC](../../../../vnc/index.html) 显示虚拟机的显示器输出，通过以下命令启动

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 2G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display none -vga qxl -vnc localhost:50000,websocket=on -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=2G,prealloc=on,share=on,merge=off -no-reboot
```

#### 配置网络

乾坤袋虚拟系统通过以下命令启动新系统

```
qemu-system-x86_64 -accel whpx -bios share\edk2-x86_64.fd -cpu Westmere,aes=on,avx=on,sse4.1=on,sse4.2=on,ssse3=on,x2apic=on,xsave=on,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -m 2G -machine q35,kernel-irqchip=on,hpet=off,vmport=off,dump-guest-core=on,mem-merge=off,hmat=on,memory-backend=ram0 -smp 2 -display none -vga qxl -vnc localhost:50000,websocket=on -netdev user,id=hn0,hostfwd=tcp::50022-:50022,hostfwd=tcp::50443-:50443 -device virtio-net-pci,netdev=hn0,id=nic1 -usb -device usb-tablet -device usb-kbd -drive id=drive-virtio-disk0,file=openwrt-24.10.0-x86-64-generic-ext4-combined-efi.qcow2,format=qcow2,if=none,cache=none,aio=native,discard=unmap,copy-on-read=on,cache.direct=on -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=drive-virtio-disk0,bus=scsi.0,rotation_rate=1,bootindex=1 -rtc base=localtime,clock=host -chardev socket,id=mon1,host=localhost,port=56666,server=on,wait=off -mon chardev=mon1,mode=control,pretty=off -debugcon file:debug.log -pidfile qemu.pid -D qemu.log -object memory-backend-ram,id=ram0,size=2G,prealloc=on,share=on,merge=off -no-reboot
```

默认系统将 eth0 配置为 LAN 端的网卡，我们需要将其设置为 WAN 端的网卡并将其配置为 DHCP 动态获取 IP 的方式，在控制台终端执行以下命令：

```
uci set network.wan=interface
uci set network.wan.device=eth0
uci set network.wan.proto=dhcp
uci set netowrk.@device[0].ports=dummy0
uci commit
```

重启系统网络配置，在控制台终端执行以下命令：

```
service network restart
```

默认系统自动获取 10.0.2.15 的 IPv4 地址，使用 10.0.2.3 作为 DNS 服务器地址

当 QEMU 自带的 DNS 服务器不能正常工作时，可以修改网络适配器的IPv4协议属性，设置使用下面的 DNS 服务器地址

首选 DNS 服务器： 8.8.8.8
备用 DNS 服务器： 8.8.4.4

LAN 端网卡我们使用 dummy 设备，需要安装对应的内核模块，在控制台终端执行以下命令：

```
opkg update
opkg install kmod-dummy
service network restart
```

这样，系统的网络设备配置完毕。

### 分区扩容

首先安装扩容需要的工具，在 OpenWrt 23.05 中执行以下命令

```
opkg update
opkg install parted
opkg install losetup
opkg install lsblk
opkg install resize2fs
```

查看当前块设备信息，执行以下命令

```
lsblk
```

输出结果如下：

```
NAME     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda        8:0    0   40G  0 disk 
├─sda1     8:1    0   16M  0 part /boot
│                                 /boot
├─sda2     8:2    0  104M  0 part /
└─sda128 259:0    0  239K  0 part 
```

可以看到 sda 磁盘大小是 40G，但是目前系统只使用了 sda1(16M) 和 sda2(104M) 共 120M 的空间

我们将对 sda2 分区扩容，把剩余的未使用空间都分给 sda2，操作如下

```
loop_device=$(losetup -f)
losetup $loop_device /dev/sda
```

将磁盘挂载到本地环回设备后，我们对本地环回设备操作就相当于对磁盘的操作

修改 sda2 分区，令其使用所有剩余磁盘空间，命令如下

```
echo -e "Fix" | parted ---pretend-input-tty "$loop_device" print
parted "$loop_device" resizepart 2 100%
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
128     17.4kB  262kB   245kB                      bios_grub
 1      262kB   17.0MB  16.8MB  fat16              legacy_boot
 2      17.0MB  126MB   109MB   ext4
```

修改分区后，sda 块设备信息如下

```
Model: Loopback device (loopback)
Disk /dev/loop0: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
128     17.4kB  262kB   245kB                      bios_grub
 1      262kB   17.0MB  16.8MB  fat16              legacy_boot
 2      17.0MB  42.9GB  42.9GB  ext4
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
128     17.4kB  262kB   245kB                      bios_grub
 1      262kB   17.0MB  16.8MB  fat16              legacy_boot
 2      17.0MB  42.9GB  42.9GB  ext4
```

确认分区已经扩容，使用以下命令查看文件系统状态

```
df -h
```

输出信息如下

```
Filesystem                Size      Used Available Use% Mounted on
/dev/root                98.3M     20.5M     75.7M  21% /
tmpfs                   993.5M     60.0K    993.4M   0% /tmp
/dev/sda1                16.0M      6.1M      9.8M  38% /boot
/dev/sda1                16.0M      6.1M      9.8M  38% /boot
tmpfs                   512.0K         0    512.0K   0% /dev
```

需要将文件系统扩容到整个分区，使用以下命令

```
loop_device=$(losetup -f)
losetup $loop_device /dev/sda2
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

### 配置本地网络访问

修改 dropbear 访问端口号为 50022，执行以下命令

```
uci set dropbear.@dropbear[0].Port='50022'
uci commit
service dropbear restart
```

完成后，使用以下命令确认是否修改成功

```
netstat -anpt |grep 50022
```

输出信息如下

```
tcp        0      0 0.0.0.0:50022           0.0.0.0:*               LISTEN      2562/dropbear
```

修改 uhttpd 访问端口号为 50080 和 50443，执行以下命令

```
uci del_list uhttpd.main.listen_http='0.0.0.0:80'
uci del_list uhttpd.main.listen_http='[::]:80'
uci add_list uhttpd.main.listen_http='0.0.0.0:50080'
uci add_list uhttpd.main.listen_http='[::]:50080'
uci del_list uhttpd.main.listen_https='0.0.0.0:443'
uci del_list uhttpd.main.listen_https='[::]:443'
uci add_list uhttpd.main.listen_https='0.0.0.0:50443'
uci add_list uhttpd.main.listen_https='[::]:50443'
uci commit
service uhttpd restart
```

完成后，使用以下命令确认是否修改成功

```
netstat -anpt |grep 50080
```

输出信息如下

```
tcp        0      0 0.0.0.0:50080           0.0.0.0:*               LISTEN      2675/uhttpd
tcp        0      0 :::50080                :::*                    LISTEN      2675/uhttpd
```

执行以下命令

```
netstat -anpt |grep 50443
```

输出信息如下

```
tcp        0      0 0.0.0.0:50443           0.0.0.0:*               LISTEN      2675/uhttpd
tcp        0      0 :::50443                :::*                    LISTEN      2675/uhttpd
```

完成修改后，执行以下命令关闭防火墙

```
service firewall stop
```

在本地电脑上访问 [https://localhost:50443/](https://localhost:50443/) 进行配置

### 配置防火墙

在防火墙规则中添加 WAN 端的端口重定向规则，以便运行我们从虚拟机外部网络管理虚拟机，执行以下命令：


设置 IPv4 的 SSH 管理端口重定向规则

```
uci set firewall.@redirect[0]=redirect
uci set firewall.@redirect[0].dest='lan'
uci set firewall.@redirect[0].target='DNAT'
uci set firewall.@redirect[0].name='SSH-ADMIN'
uci set firewall.@redirect[0].proto='tcp'
uci set firewall.@redirect[0].src='wan'
uci set firewall.@redirect[0].src_dport='50022'
uci set firewall.@redirect[0].dest_ip='192.168.1.1'
uci set firewall.@redirect[0].dest_port='50022'
uci set firewall.@redirect[0].family='ipv4'
uci commit
```


设置 IPv6 的 SSH 管理端口重定向规则

```
uci set firewall.@redirect[1]=redirect
uci set firewall.@redirect[1].dest='lan'
uci set firewall.@redirect[1].target='DNAT'
uci set firewall.@redirect[1].name='SSH-ADMIN6'
uci set firewall.@redirect[1].proto='tcp'
uci set firewall.@redirect[1].src='wan'
uci set firewall.@redirect[1].src_dport='50022'
uci set firewall.@redirect[1].dest_ip='fe80::1419:55ff:feda:da1c'
uci set firewall.@redirect[1].dest_port='50022'
uci set firewall.@redirect[1].family='ipv6'
uci commit
```

设置 IPv4 的 HTTPS 管理端口重定向规则

```
uci set firewall.@redirect[2]=redirect
uci set firewall.@redirect[2].dest='lan'
uci set firewall.@redirect[2].target='DNAT'
uci set firewall.@redirect[2].name='HTTPS-ADMIN'
uci set firewall.@redirect[2].family='ipv4'
uci set firewall.@redirect[2].proto='tcp'
uci set firewall.@redirect[2].src='wan'
uci set firewall.@redirect[2].src_dport='50443'
uci set firewall.@redirect[2].dest_ip='192.168.1.1'
uci set firewall.@redirect[2].dest_port='50443'
uci commit
```

设置 IPv6 的 HTTPS 管理端口重定向规则

```
uci set firewall.@redirect[3]=redirect
uci set firewall.@redirect[3].dest='lan'
uci set firewall.@redirect[3].target='DNAT'
uci set firewall.@redirect[3].name='HTTPS-ADMIN6'
uci set firewall.@redirect[3].family='ipv6'
uci set firewall.@redirect[3].proto='tcp'
uci set firewall.@redirect[3].src='wan'
uci set firewall.@redirect[3].src_dport='50443'
uci set firewall.@redirect[3].dest_ip='fe80::4873:6ff:fec0:2ebd'
uci set firewall.@redirect[3].dest_port='50443'
uci commit
```

完成后，使用以下命令重启防火墙：

```
service firewall restart
```


## 参考资料

1. [Running Windows 11 at near-native speed in QEMU on Windows to have sensitive data encrypted](https://windowsforum.com/threads/running-windows-11-at-near-native-speed-in-qemu-on-windows-to-have-sensitive-data-encrypted.339034/)
2. [Running Android games on Windows 10/11 using QEMU+Hyper-V+virglrenderer+Bliss OS](https://guanzhang.medium.com/running-android-games-on-windows-10-11-4eea9be9a06b)