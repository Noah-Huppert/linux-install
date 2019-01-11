# Instructions
Linux installation instructions.

# Table Of Contents
- [Live USB](#live-usb)
- [Run Installation Script](#run-installation-script)
    - [Network Setup](#network-setup)
    - [Install Salt](#install-salt)

# Live USB
Create a bootable USB with Void Linux:  

```
./scripts/mkiso.sh EXTERNAL_DEVICE
```

1. Download the latest Void Linux Live MUSL ISO file
2. Write the ISO to a USB drive:
   ```
   sudo dd if=VOID_LIVE_MUSL.iso of=/dev/USB_DRIVE_DEVICE
   ```

# Run Installation Script
Boot from the Live USB, then complete the following steps.

## Nework Setup
Connect to the internet via WiFi:

1. Add a WPA supplicant entry:
   ```
   wpa_passphrase SSID PASSWORD >> /etc/wpa_supplicant/wpa_supplicant.conf
   ```
2. Restart WPA supplicant via the DHCPCD service
   ```
   sv restart dhcpcd
   ```
   After a few moments you will be connected to the internet.

## Install Salt
Install SaltStack:

```
xbps-install -Su salt
```
