# OpenWrt 23.05 x86_64 GuestOS

  [return to README](https://gitee.com/david921518/qkd-app/blob/gitee/README.en.md)
   
## Default Virtual Machine

  Intel Q35 Chipset Board

| Hardware | Configuration |
|----------|---------------|
| CPU | Intel Core2 i3 |
| RAM | 1G |
| Network Card 1 | Intel E1000 (Intel 82540EM Giga) |
| Network Card 2 | Intel E1000 (Intel 82540EM Giga) |
| SATA Controller | Intel ICH9 AHCI (Intel 82801IR/IO/IH SATA Controller) |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## Default GuestOS Settings

  OpenWrt 23.05 x86_64 GuestOS settings

| Parameter | Settings |
|-----------|----------|
| System User Account | root |
| System User Password | qkd1234567 |
| System SSH port | 50022 |
| System HTTPS admin port | 50443 |
| System TTYD port | 57681 |
| LAN Interface | br-lan(eth0) |
| WAN Interface | eth1 |
| docker Interface | docker0 |

## VMOS Examples

  OpenWrt 23.05 x86_64 VMOS Configuration

| Guest Operating System | Link |
|-----|------|
| Windows | [Windows-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Windows-Q35_x86_64-vmos.toml) |
| Ubuntu/Linux | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS | [macOS-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/macOS-Q35_x86_64-vmos.toml) |
| More... | [doc/vmos-examples/OpenWrt2305/](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/OpenWrt2305/README.en.md) |

## Reference

- 1 [OpenWrt 23.05](https://openwrt.org/releases/23.05/start)
- 2 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
