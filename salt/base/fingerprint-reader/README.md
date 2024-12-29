# Fingerprint Reader
Linux fingerprint reader support.

# Table Of Contents
- [Instructions](#instructions)

# Instructions
To enroll fingerprints:

``` shell
fprintd-enroll
````

Or:

``` shell
fprintd-delete "$USER"
for finger in {left,right}-{thumb,{index,middle,ring,little}-finger}; do fprintd-enroll -f "$finger" "$USER"; done
```
