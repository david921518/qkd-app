# OpenWrt 23.05 x86_64 虚拟目标操作系统
  [返回自述](https://gitee.com/david921518/qkd-app/blob/gitee/README.md)
  
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

## 默认操作系统设置
 OpenWrt 23.05 x86_64 虚拟目标操作系统设置
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
 OpenWrt 23.05 x86_64 虚拟目标操作系统设置
| 宿主机系统 | 配置文件 |
|-----|------|
| Windows | [Windows-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Windows-Q35_x86_64-vmos.toml) |
| Ubuntu/Linux | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS | [macOS-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/macOS-Q35_x86_64-vmos.toml) |
| 更多信息 | [doc/vmos-examples/openwrt2305/](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/README.md) |

## 参考资料
- 1、 [OpenWrt 23.05](https://openwrt.org/zh/releases/23.05/start)
- 2、 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
