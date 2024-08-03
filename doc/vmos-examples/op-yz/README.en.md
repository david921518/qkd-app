# OP/YZ(YingZheng) GuestOS
  [return to README](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/README.en.md)

  OP/YZ(YingZheng) Distro is for enterprise users, providing common enterprise services such as email and website.

  OP/YZ(YingZheng) Distro is based on OpenWrt 23.05, using Docker container technology to provide users with secure and stable extended functions.

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
| RAM | 1G |
| Network Card 1 | Intel E1000E (Intel 82574 Gigabit Ethernet Controller) |
| Network Card 2 | Intel E1000E (Intel 82574 Gigabit Ethernet Controller) |
| SATA Controller | virtio-blk-pci Controller |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## Default GuestOS Settings
 OP/YZ(YingZheng) GuestOS settings
| Parameter | Settings |
|-----------|----------|
| System User Account | root |
| System User Password | qkd1234567 |
| System SSH port | 50022 |
| System HTTPS admin port | 50443 |
| System TTYD port | 57681 |
| User HTTPS port | 443 |
| User SMTP port | 25 |
| User SMTP over SSL port | 465 |
| User Message Submission port | 587 |
| User IMAP over SSL port | 993 |
| LAN Interface | br-lan(eth0) |
| WAN Interface | eth1 |
| docker Interface | docker0 |
| local work Interface | wpnet |


## VMOS Examples
 OP/YZ(YingZheng) VMOS Configuration
| Host Operating System | Guest Operating System | Link |
|-----------------------|------------------------|------|
| Windows(x86_64) | Q35/x86_64 | [Windows-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/op-yz/Windows-Q35_x86_64-vmos.toml) |
| Windows(x86_64) | armvirt/armv8 | [Windows-armvirt_armv8-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/op-yz/Windows-armvirt_armv8-vmos.toml) |
| Ubuntu/Linux(x86_64) | Q35/x86_64 | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/op-yz/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS(x86_64) | Q35/x86_64 | [macOS-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/op-yz/macOS-Q35_x86_64-vmos.toml) |
| More... | all | [doc/vmos-examples/op-yz/](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/op-yz/README.en.md) |

## Reference
- 1 [OpenWrt 23.05](https://openwrt.org/releases/23.05/start)
- 2 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
- 3 [QEMU ARM ‘virt’ generic virtual platform (virt)](https://www.qemu.org/docs/master/system/arm/virt.html)
