# Linux File System Tree Layout

## Filesystem Hierarch Standard (FHS)

* see the guide line for the [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf)

### Table : Main Directories

| DIRECTORY |	IN FHS? |	PURPOSE |
|-----------| --------- | ----------- |
| /	| Yes  | Primary directory of the entire filesystem hierarchy.|
| /bin |Yes |  Essential executable programs that must be available in single user mode.|
| /boot |Yes | Files needed to boot the system, such as the kernel, initrd or initramfs images, and boot configuration files and bootloader programs. |
| /dev | Yes | Device Nodes, used to interact with hardware and software devices.|
| /etc | Yes | System-wide configuration files.|
| /home | Yes | User home directories, including personal settings, files, etc.|
| /lib | Yes | Libraries required by executable binaries in /bin and /sbin.|
| /lib64 | No | 64-bit libraries required by executable binaries in /bin and /sbin, for ystems which can run both 32-bit and 64-bit programs. |
| /media | Yes | Mount points for removable media such as CDs, DVDs, USB sticks, etc.|
| /mnt | Yes | Temporarily mounted filesystems.|
| /opt | Yes | Optional application software packages.|
| /proc| Yes | Virtual pseudo-filesystem giving information about the system and processes running on it. Can be used to alter system parameters.|
| /sys | No | Virtual pseudo-filesystem giving information about the system and processes running on it. Can be used to alter system parameters. Similar to a device tree and is part of the Unified Device Model.|
| /root | Yes | Home directory for the root user.|
| /sbin | Yes | Essential system binaries.|
| /srv | Yes | Site-specific data served up by the system. Seldom used.|
| /tmp | Yes | Temporary files; on many distributions lost across a reboot and may be a ramdisk in memory. |
| /usr | Yes | Multi-user applications, utilities and data; theoretically read-only. |
| /var | Yes | Variable data that changes during system operation. |

## The Root (/) Directory

* special and is often in a special dedicate partion, with other components getting mounted later like:
  * `/home`
  * `/var`
  * `/opt` 

* root partition must contain all essential files required to boot the system 

* Then be able to mount other file systems

* It will need : {utilities, configuration files, boot loader information other essential startup data}

* It must be able to do the following:
  * Boot the system
  * restore the system from system backups on external media or from a NAS (something like this)
  * recover or repair the system -- a maintainer needs to have the tools to diagnose and rebuild the damaged system'


## /bin

* obviously important:
  * contains executables and scripts to be by system admins and normal users
  * contains executables that are used indirectly by scripts like `/bin/bash` something I use all the time when sshing or connecting to a container

### Required programs for /bin/

```bash
cat, chgrp, chmod, chown, cp, date, dd, df, dmesg, echo
false, hostname, kill, ln, login, ls, mkdir, mknod, more,
mount, mv, ps, pwd, rm, rmdir, sed, sh, stty, su, sync,
true, umount and uname
```

### Notes

* Command binaries that are deemed nonessential enough to merit a place in `/bin` go in `/usr/bin`. Programs required only by non-root users are placed in this category.

*Interestingly:*, 

* Some very recent distributions are abandoning the strategy of separating `/bin` and `/usr/bin` (as well as /sbin and `/usr/sbin`) and just have one directory with symbolic links, thereby preserving a two directory view. They view the time-honored concept of enabling the possibility of placing `/usr` on a separate partition to be mounted after boot as obsolete.