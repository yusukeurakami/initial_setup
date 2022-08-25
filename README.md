# initial_setup

The entire script to setup the inital setting for ubuntu


# Ubuntu root files related to booting 
## Grub setting
### `/etc/default/grub`
- Have all grub setting when you boot. Changing the default kernel or set the timeout for grub can be set here.
- the setting inside this will be reflected when `sudo update-grub` and reboot. (/usr/sbin/update-grub2 is just a symbolic link to /usr/sbin/update-grub)

### `/boot`
- the place having kernels. If the name of the kernel not in here, it will now show up during the grub.

### `/boot/grub/grub.cfg`
- The place which have a index of each kernel. You can search for kernel name using grep like `grep menuentry /boot/grub/grub.cfg`.
- you can use the name of the kernel instead of index to set `GRUB_DEFAULT='Ubuntu, with Linux 5.4.0-122-generic'`

# Ubuntu root files related to group

### `/etc/group`


# Ubuntu command related to user, group, super user
su
adduser
useradd
pword
usermod
chmod
chown
chgrp
