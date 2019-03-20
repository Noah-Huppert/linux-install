# Instructions
Linux installation instructions.

# Table Of Contents
- [Live USB](#live-usb)
- [Setup](#setup)

# Live USB
Create a Void Linux live USB which will be used for automated installation.  

Run:

```
./setup-scripts/mk-install-media.sh EXTERNAL_DEVICE
```

# Setup
Follow the instructions in the following sections to install Void linux.

## Disable Secure Boot
Secure boot interferes with your computer's ability to boot form a USB.  

Disable it in your computer's BIOS configuration.

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

### Password-less Wireless Network
Open the `/etc/wpa_supplicant/wpa_supplicant.conf` file and add the following:

```
network={
	ssid="NETWORK_SSID"
	key_mgmt=NONE
}
```

Then enable the `wpa_supplicant` service:

```
# ln -s /etc/sv/wpa_supplicant /var/service
```

### Password Protected Wireless Network
Run the following
```
# wpa_passphrase "NETWORK_SSID" "NETWORK_PASSWORD" >> /etc/wpa_supplicant/wpa_supplicant.conf
# sv start wpa_supplicant
```

### Eduroam
Open the `/etc/wpa_supplicant/wpa_supplicant.conf` file and add the following:
```
network={
	ssid="eduroam"
	key_mgmt=WPA-EAP
	eap=TTLS
	phase2="auth=PAP"
	identity="YOUR_SCHOOL_EMAIL"
	password="YOU_SCHOOL_NETID_PASSWORD"
}
```

Then enable the `wpa_supplicant` service:

```
# ln -s /etc/sv/wpa_supplicant /var/service
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

## Download This Repository
```
xbps-install -Sy curl unzip
curl -L https://github.com/Noah-Huppert/linux-install/archive/master.zip > linux-install-master.zip
unzip linux-install-master.zip
cd linux-install-master
```

The rest of this guide will assume you are in the `linux-install-master` directory.

## Setup Encrypted Partition
Run:

```
./live-scripts/crypsetup.sh -p ROOT_PARTITION -c cryptroot
```

## Install Void Linux
Run:

```
./live-scripts/install.sh -c cryptroot -b BOOT_PARTITION
```
