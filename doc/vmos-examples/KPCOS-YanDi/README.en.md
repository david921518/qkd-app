# KPCOS/YanDi GuestOS

  [return to README](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/README.en.md)
  
## Default Virtual Machine

  **Intel Q35 Chipset Board**

| Hardware | Configuration |
|----------|---------------|
| CPU | Intel Core2 i3 |
| RAM | 4G |
| Network Card 1 | Intel E1000 (Intel 82540EM Gigabit Ethernet Controller) |
| SATA Controller | Intel ICH9 AHCI (Intel 82801IR/IO/IH SATA Controller) |
| Hard Disk | QEMU HARDDISK (Storage size 40G) |
| DVD/CD-ROM | QEMU DVD-ROM |

  **armvirt 64 variant board**

| Hardware | Configuration |
|----------|---------------|
| CPU | ARM cortex-a57 |
| RAM | 4G |
| Network Card 1 | Intel E1000E (Intel 82574 Gigabit Ethernet Controller) |
| SATA Controller | virtio-blk-pci Controller |
| Hard Disk | QEMU HARDDISK (Storage size 20G) |
| DVD/CD-ROM | QEMU DVD-ROM |

## Default GuestOS Settings

  **KPCOS/YanDi GuestOS settings**

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

  **KPCOS/YanDi VMOS Configuration**

| Host Operating System | Guest Operating System | Link |
|-----------------------|------------------------|------|
| Windows(x86_64) | Q35/x86_64 | [Windows-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/KPCOS-YanDi/Windows-Q35_x86_64-vmos.toml) |
| Windows(x86_64) | armvirt/armv8 | [Windows-armvirt_armv8-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/KPCOS-YanDi/Windows-armvirt_armv8-vmos.toml) |
| Ubuntu/Linux(x86_64) | Q35/x86_64 | [Ubuntu_Linux-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/KPCOS-YanDi/Ubuntu_Linux-Q35_x86_64-vmos.toml) |
| macOS(x86_64) | Q35/x86_64 | [macOS-Q35_x86_64-vmos.toml](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/KPCOS-YanDi/macOS-Q35_x86_64-vmos.toml) |
| More... | all | [doc/vmos-examples/KPCOS-YanDi/](https://github.com/david921518/qkd-app/blob/master/doc/vmos-examples/KPCOS-YanDi/README.en.md) |

## Reference

- 1 [KPCOS/YanDi](https://gitee.com/m8t/kpcos/tree/master/distro/yandi)
- 2 [Intel® Q35 Express Chipset for Embedded Computing](https://www.intel.cn/content/dam/www/public/us/en/documents/product-briefs/q35-chipset-brief.pdf)
- 3 [QEMU ARM ‘virt’ generic virtual platform (virt)](https://www.qemu.org/docs/master/system/arm/virt.html)
