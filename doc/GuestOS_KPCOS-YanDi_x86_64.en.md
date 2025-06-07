# KPCOS/YanDi x86_64 GuestOS

  [return to README](https://gitee.com/david921518/qkd-app/blob/gitee/README.en.md)
   
## Default Virtual Machine

  Intel Q35 Chipset Board

| Hardware | Configuration |
|----------|---------------|
| CPU | Intel Core2 i3 |
| RAM | 2G |
| Network Card 1 | Intel E1000 (Intel 82540EM Giga) |
| SATA Controller | Intel ICH9 AHCI (Intel 82801IR/IO/IH SATA Controller) |
| Hard Disk | QEMU HARDDISK (Storage size 40G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## Default GuestOS Settings

  KPCOS/YanDi x86_64 GuestOS settings

| Parameter | Settings |
|-----------|----------|
| System User Account | root |
| System User Password | KoudaiPC@123 |
| System SSH port | 50022 |
| System VNC port | 55900 |
| Default User Account | kpc |
| Default User Password | KoudaiPC@123 |
| Ethernet Interface | eth0 |

## VMOS Examples

  KPCOS/YanDi x86_64 VMOS Configuration

| Guest Operating System | Link |
|-----|------|
| Windows | [Windows-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/Windows-Q35_x86_64-vmos.toml) |
| Ubuntu/Linux | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS | [macOS-Q35_x86_64-vmos.toml](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/macOS-Q35_x86_64-vmos.toml) |
| More... | [doc/vmos-examples/KPCOS-YanDi/](https://gitee.com/david921518/qkd-app/blob/gitee/doc/vmos-examples/KPCOS-YanDi/README.en.md) |

## Reference

- 1 [KPCOS/YanDi](https://gitee.com/m8t/kpcos/tree/master/distro/yandi)
- 2 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
