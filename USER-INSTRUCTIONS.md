# User Instructions
Linux installation instructions for end users.

# Table Of Contents
- [Live USB](#live-usb)
- [Setup](#setup)

# Live USB
Create a Void Linux live USB which will be used for automated installation.  

Run:

```
./setup-scripts/mk-install-media.sh -d EXTERNAL_DEVICE
```

# Setup
Follow the instructions in the following sections to install Void Linux.  

## Disable Secure Boot
Secure boot interferes with your computer's ability to boot from a USB device.

Disable it in your computer's BIOS configuration.

## Set Hardware Clock
Set the computer's hardware clock in the BIOS configuration.

This clock should be set to the current UTC time.

The operating system will translate the clock from UTC to your local timezone.

## Boot From The Live USB
The rest of the guide will assume you are running commands on the live USB.  

1. Insert the live USB
2. Open your computer's one time boot menu
3. Boot from the USB

## Partition
Use `lsblk` to list devices.  

Use `cfdisk DEVICE` to partition your disk.

The rest of this guide will refer to partitions specific to your device by the 
following names:

- `ROOT_PARTITION`: Linux root file system partition
- `BOOT_PARTITION`: Partition with boot data
## Connect To The Internet
The rest of this guide requires you be connected to the internet.  

### Standard WiFi Network
Run:

```
# /etc/linux-install/live-scripts/wifi.sh -s SSID [-p PASSWORD]
```

### Eduroam
Run:

```
# /etc/linux-install/live-scripts/eduroam.sh -u USERNAME -p PASSWORD
```

### Debugging A Wireless Connection
After making the above changes it can take up to a minute to connect to 
the internet.  

If you are still having trouble try running the `dhcpcd` service manually:

```
# sv stop dhcpcd
# /etc/sv/dhcpcd/run
```
Check the output for any errors.  

If this does not show you any errors try running `wpa_supplicant` manually:

```
# sv stop wpa_supplicant
# wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf -i WIRELESS_INTERFACE
```
Check the output for any errors.  

After debugging ensure the `dhcpcd` and `wpa_supplicant` services are running:
```
# sv start dhcpcd wpa_supplicant
```

## Update Live USB
Update the live USB's system by running:

```
# xbps-install -Syu
```

## Setup Encrypted Partition
Run:

```
# /etc/linux-install/live-scripts/crypsetup.sh -p ROOT_PARTITION -c cryptroot
```

## Install Void Linux
Run:

```
# /etc/linux-install/live-scripts/install.sh -c -r cryptroot -b BOOT_PARTITION
```

Pass the `-e ENV` option to set the Salt environment to setup.
