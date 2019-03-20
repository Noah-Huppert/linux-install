# Instructions
Linux installation instructions.

# Table Of Contents
- [Live USB](#live-usb)
- [Run Installation Script](#run-installation-script)

# Live USB
Create a Void Linux live USB which will be used for automated installation.  

Run:

```
./setup-scripts/mk-install-media.sh EXTERNAL_DEVICE
```

# Setup
1. Disable secure boot in BIOS
2. Boot from the Live USB
3. Partition
   ```
   # lsblk
   # cfdisk DEVICE
   ```
   The rest of this guide will refer to partitions specific to your device 
   by the following names:
	- `ROOT_PARTITION`: Linux root file system partition
	- `BOOT_PARTITION`: Partition with boot data
4. Connect to internet
   If the network you are connecting to requires a password:

   ```
   # wpa_passphrase "SSID" "PASSWORD" >> /etc/wpa_supplicant/wpa_supplicant.conf
   # sv restart dhcpcd
   ```

   If you are trying to connect to eduroam open the 
   `/etc/wpa_supplicant/wpa_supplicant.conf` file and add the following:

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
5. Download this repository:
   ```
   curl -L "https://github.com/Noah-Huppert/linux-install/archive/master.zip" > linux-install-master.zip
   unzip linux-install-master.zip
   mv linux-install-master linux-install
   cd linux-install
   ```
   The rest of this guide will assume you are in the `linux-install` directory.
6. Setup encrypted partition:
   ```
   ./live-scripts/crypsetup.sh -p ROOT_PARTITION -c cryptroot
   ```
7. Install Void Linux:
   ```
   ./live-scripts/install.sh -c cryptroot -b BOOT_PARTITION
   ```
