# OpenWrt 23.05 GuestOS
  [return to README](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/README.en.md)
  
## Default Virtual Machine
 Intel Q35 Chipset Board
| Hardware | Configuration |
|----------|---------------|
| CPU | Intel Core2 i3 |
| RAM | 1G |
| Network Card 1 | Intel E1000 (Intel 82540EM Gigabit Ethernet Controller) |
| Network Card 2 | Intel E1000 (Intel 82540EM Gigabit Ethernet Controller) |
| SATA Controller | Intel ICH9 AHCI (Intel 82801IR/IO/IH SATA Controller) |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

 armvirt 64 variant board
| Hardware | Configuration |
|----------|---------------|
| CPU | ARM cortex-a57 |
| RAM | 128M |
| Network Card 1 | Intel E1000E (Intel 82574 Gigabit Ethernet Controller) |
| Network Card 2 | Intel E1000E (Intel 82574 Gigabit Ethernet Controller) |
| SATA Controller | virtio-blk-pci Controller |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

MIPS Technologies Incorporation Malta CoreLV board
| Hardware | Configuration |
|----------|---------------|
| CPU | MIPS 24Kc |
| RAM | 256M |
| Network Card 1 | AMD PCnet32 (AMD Am79C973 Fast Ethernet Controller) |
| Network Card 2 | AMD PCnet32 (AMD Am79C973 Fast Ethernet Controller) |
| IDE Controller | Intel PIIX4E IDE mode (Intel 82371EB PCI-IDE Controller) |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## Default GuestOS Settings
 OpenWrt 23.05 GuestOS settings
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
 OpenWrt 23.05 VMOS Configuration
| Host Operating System | Guest Operating System | Link |
|-----------------------|------------------------|------|
| Windows(x86_64) | Q35/x86_64 | [Windows-Q35_x86_64-vmos.toml](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/Windows-Q35_x86_64-vmos.toml) |
| Windows(x86_64) | armvirt/armv8 | [Windows-armvirt_armv8-vmos.toml](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/Windows-armvirt_armv8-vmos.toml) |
| Windows(x86_64) | Malta/mips_be | [Windows-Malta_mips-vmos.toml](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/Windows-Malta_mips-vmos.toml) |
| Ubuntu/Linux(x86_64) | Q35/x86_64 | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS(x86_64) | Q35/x86_64 | [macOS-Q35_x86_64-vmos.toml](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/macOS-Q35_x86_64-vmos.toml) |
| More... | all | [doc/vmos-examples/openwrt2305/](https://gitcode.com/david921518/qkd-app/blob/gitcode/doc/vmos-examples/OpenWrt2305/README.en.md) |

## Reference
- 1 [OpenWrt 23.05](https://openwrt.org/releases/23.05/start)
- 2 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
- 3 [Malta™ User's Manual](https://it.uu.se/edu/course/homepage/datsystDV/ht07/project/tools/machinedata/malta-board.pdf)
- 4 [QEMU ARM ‘virt’ generic virtual platform (virt)](https://www.qemu.org/docs/master/system/arm/virt.html)
