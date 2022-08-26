# initial_setup

The entire script to setup the inital setting for ubuntu


## Ubuntu commands/root_files related to booting 
### `/etc/default/grub`
- Have all grub setting when you boot. Changing the default kernel or set the timeout for grub can be set here.
- the setting inside this will be reflected when `sudo update-grub` and reboot. (/usr/sbin/update-grub2 is just a symbolic link to /usr/sbin/update-grub)

### `/boot`
- Only pertain the files used in the very first stage of the Linux startip procedure.
- the place having kernels. If the name of the kernel not in here, it will now show up during the grub.

### `/boot/grub/grub.cfg`
- The place which have a index of each kernel. You can search for kernel name using grep like `grep menuentry /boot/grub/grub.cfg`.
- you can use the name of the kernel instead of index to set `GRUB_DEFAULT='Ubuntu, with Linux 5.4.0-122-generic'`

## Ubuntu commands/root_files related to group

### `/etc/group`

### `/etc/passwd`

## Ubuntu commands/root_files related to user

### `/etc/sudoers`

### `su`

### `adduser`

## Ubuntu commands/root_files related to host name

### `/etc/hosts`

### `/etc/hostname`

## Ubuntu commands/root_files related to dpkg and apt

### `/etc/apt/sources.list.d`

## Ubuntu commands/root_files related to realtime kernel

### `/etc/security/limits.conf`

## Ubuntu commands/root_files related to Xserver

### `/etc/X11`

### `xhost`

### `xinit`

### `/opt`
Place to keep additional thrid-party software. ROS is here.

# Ubuntu command related to user, group, super user
su
adduser
useradd
pword
usermod
chmod
chown
chgrp
