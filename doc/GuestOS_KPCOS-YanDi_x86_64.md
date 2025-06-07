# KPCOS/炎帝 x86_64 虚拟目标操作系统

  [返回自述](https://gitee.com/david921518/qkd-app/blob/gitee/README.md)
  
## 默认虚拟机

  采用Intel Q35芯片组的主板

| 硬件 | 配置 |
|------|------|
| CPU | Intel 酷睿2 i3 |
| 内存 | 2G |
| 网卡1 | 英特尔 E1000 (Intel 82540EM GigaNet) |
| 硬盘控制器 | 英特尔 ICH9 AHCI 模式(Intel 82801IR/IO/IH SATA 控制器) |
| 硬盘 | QEMU 硬盘 (容量 40G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## 默认操作系统设置

  KPCOS/炎帝 x86_64 虚拟目标操作系统设置

| 参数 | 设置 |
|------|------|
| 系统用户账号 | root |
| 系统用户密码 | KoudaiPC@123 |
| 系统 SSH 端口 | 50022 |
| 系统 VNC 端口 | 55900 |
| 默认用户账号 | kpc |
| 默认用户密码 | KooudiaPC@123 |
| 以太网络接口 | eth0 |

## 参考虚拟机系统配置

  KPCOS/炎帝 x86_64 虚拟目标操作系统设置

| 宿主机系统 | 配置文件 |
|------|------|
| Windows | [Windows-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/Windows-Q35_x86_64-vmos.toml) |
| Ubuntu/Linux | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS | [macOS-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/macOS-Q35_x86_64-vmos.toml) |
| 更多信息 | [doc/vmos-examples/KPCOS-YanDi/](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/README.md) |

## 参考资料

- 1、 [KPCOS/炎帝](https://gitee.com/m8t/kpcos/tree/master/distro/yandi)
- 2、 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
