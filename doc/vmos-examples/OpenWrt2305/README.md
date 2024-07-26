# OpenWrt 23.05 虚拟目标操作系统
  [返回自述](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/README.md)
  
## 默认虚拟机
 采用Intel Q35芯片组的主板
| 硬件 | 配置 |
|-----|------|
| CPU | Intel 酷睿2 i3 |
| 内存 | 1G |
| 网卡1 | 英特尔 E1000 (Intel 82540EM GigaNet) |
| 网卡2 | 英特尔 E1000 (Intel 82540EM GigaNet) |
| 硬盘控制器 | 英特尔 ICH9 AHCI 模式(Intel 82801IR/IO/IH SATA 控制器) |
| 硬盘 | QEMU 硬盘 (容量 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

armvirt 64 variant 主板
| 硬件 | 配置 |
|-----|------|
| CPU | ARM cortex-a57 |
| 内存 | 128M |
| 网卡1 | 英特尔 E1000 (Intel 82540EM GigaNet) |
| 网卡2 | 英特尔 E1000 (Intel 82540EM GigaNet) |
| 硬盘控制器 | virtio-blk-pci 控制器) |
| 硬盘 | QEMU 硬盘 (容量 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

MIPS Technologies Incorporation Malta CoreLV 主板
| 硬件 | 配置 |
|-----|------|
| CPU | MIPS 24Kf |
| 内存 | 128M |
| 网卡1 | AMD PCnet32 (AMD Am79C973 Fast Ethernet 控制器) |
| 网卡2 | AMD PCnet32 (AMD Am79C973 Fast Ethernet 控制器) |
| 硬盘控制器 | 英特尔 PIIX4E IDE 模式(Intel 82371EB PCI-IDE 控制器) |
| 硬盘 | QEMU 硬盘 (容量 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |


## 默认操作系统设置
 OpenWrt 23.05 虚拟目标操作系统设置
| 参数 | 设置 |
|-----|------|
| 系统用户账号 | root |
| 系统用户密码 | qkd1234567 |
| 系统 SSH 端口 | 50022 |
| 系统 HTTPS 管理端口 | 50443 |
| 系统 TTYD 端口 | 57681 |
| LAN 接口 | br-lan(eth0) |
| WAN 接口 | eth1 |
| docker 接口 | docker0 |

## 参考虚拟机系统配置
 OpenWrt 23.05 虚拟目标操作系统设置
| 宿主机系统 | 目标虚拟机 | 配置文件 |
|-----|------|------|
| Windows(x86_64) | Q35/x86_64 | [Windows-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Windows-Q35_x86_64-vmos.toml) |
| Windows(x86_64) | armvirt/armv8 | [Windows-armvirt_armv8-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Windows-armvirt_armv8-vmos.toml) |
| Windows(x86_64) | Malta/mips_be | [Windows-Malta_mips-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Windows-Malta_mips-vmos.toml) |
| Ubuntu/Linux(x86_64) | Q35/x86_64 | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS(x86_64) | Q35/x86_64 | [macOS-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/macOS-Q35_x86_64-vmos.toml) |
| 更多信息 | all | [doc/vmos-examples/openwrt2305/](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/README.md) |

## 参考资料
- 1、 [OpenWrt 23.05](https://openwrt.org/zh/releases/23.05/start)
- 2、 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
- 3、 [Malta™ User's Manual](https://it.uu.se/edu/course/homepage/datsystDV/ht07/project/tools/machinedata/malta-board.pdf)
- 4、 [QEMU ARM ‘virt’ generic virtual platform (virt)](https://www.qemu.org/docs/master/system/arm/virt.html)
