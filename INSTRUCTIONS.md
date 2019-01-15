# Instructions
Linux installation instructions.

# Table Of Contents
- [Live USB](#live-usb)
    - [Rudimentary Void Linux Install](#rudimentary-void-linux-install)
    - [Create Live USB For Installation](#create-live-usb-for-installation)
- [Run Installation Script](#run-installation-script)

# Live USB
To create a Void Linux live USB a rudimentary installation of Void Linux 
is required.

*Why?: The [Void mklive](https://github.com/void-linux/void-mklive) tool can 
only be run on Void Linux. This tool is required until 
[Void mklive PR #14](https://github.com/void-linux/void-mklive/pull/14) 
is merged, as the default live image currently does not have enough space to 
install the required setup tools.*  

## Rudimentary Void Linux Install
If you do not have an existing Void Linux installation complete the following
steps to obtain one.  

These steps will create a basic Void Linux install which we will use to create 
a Void Linux live USB for installation. We will overwrite this installation 
almost immediately.

1. Create a copy of this repository that will be accessible from the live USB. 
   You will use scripts in this repository later.  

   A recommended location is your boot directory. You will delete this 
   copy later.

2. Create a rudimentary bootable USB with Void Linux:  

   ```
   ./scripts/mk-temp-iso.sh EXTERNAL_DEVICE
   ```
   Where `EXTERNAL_DEVICE` is the device file of your USB device (ex: `/dev/sdb`).
3. Boot from this external device
4. Run `void-installer` with default options. Install on any partition 
   you choose

## Create Live USB For Installation
Create a Void Linux live USB which will be used for automated installation.  

Complete the following steps on an existing Void Linux installation:

1. Access the copy of this repository  

   If stored in your boot directory run:

   ```
   mount BOOT_PARTITION /mnt
   ```

   The location of this repository will be referred to as `REPO_DIR` in 
   the future
2. (Optional) If you are running a new rudimentary Void Linux and need to 
   connect to the internet run:

   ```
   REPO_DIR/scripts/wifi.sh SSID PASSWORD
   ```
3. Create a custom Void Linux bootable USB which will be used for installation 
   by running:

   ```
   REPO_DIR/scripts/mk-install-iso.sh EXTERNAL_DEVICE
   ```

# Run Installation Script
Boot from the Live USB, then complete the following steps.

1. Access the copy of this repository
2. Run the installation script:

   ```
   REPO_DIR/scripts/install.sh
   ```
3. Delete the copy of this repository
