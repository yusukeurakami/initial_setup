# initial_setup

The entire script to setup the inital setting for ubuntu


## Ubuntu commands/root_files related to booting 
### `/etc/default/grub`
- Have all grub setting when you boot. Changing the default kernel or set the timeout for grub can be set here.
- the setting inside this will be reflected when `sudo update-grub` and reboot. (/usr/sbin/update-grub2 is just a symbolic link to /usr/sbin/update-grub)

### `update-grub`
- The command reflected the change in `/etc/default/grub` to the system. Needs reboot.
- `/usr/sbin/update-grub2` is just a symbolic link to `/usr/sbin/update-grub`, so no difference with these two.

### `/boot`
- Only pertain the files used in the very first stage of the Linux startip procedure.
- the place having kernels. If the name of the kernel not in here, it will now show up during the grub.

### `/boot/grub/grub.cfg`
- The place which have a index of each kernel. You can search for kernel name using grep like `grep menuentry /boot/grub/grub.cfg`.
- you can use the name of the kernel instead of index to set `GRUB_DEFAULT='Ubuntu, with Linux 5.4.0-122-generic'`

## Ubuntu commands/root_files related to group

### `/etc/group`
- The file that is used to map a Group Name into a Group ID (integer).
- it has a list of users that belong to the group. (e.g. `sudo` user name)

### `groups`
- The command to lookup `/etc/group` and print which groups the user belongs to.
- You can also do `groups USERNAME` to check the groups belonging for other users.


## Ubuntu commands/root_files related to user

### `/etc/passwd`
- The file that is used to map a User Name into a User ID (just a number).
- Each line represent one user and other info.
- It tells the primary group that user belongs to.
- Actual password for the login is encryped and stored in `/etc/shadow` so not in here.

#### The difference between the information in these two files.
- `/etc/passwd` shows each user's primary group. `/etc/group` shows users who have a given group as one of their supplementary groups.
- When you want to know what kind of group exists, and who belongs to the group => `/etc/group`
- When you want to know what kind of user exists, and check User ID, Group ID, default Shell for that user. => `etc/passwd` 

### `passwd`
- Change the passwd of the current user.
- You can change other user's password by `passwd USERNAME`.
- Technically you can change user's real-name or default-shell with this command but not preferred.

### `adduser`
- Typical command to add a new user by `sudo adduser NEWUSERNAME`
- Need to enter a password for this user.

### `useradd`
- the script which runs behind the `adduser`.
- It can basically do the same with using the options. But `adduser` is more user friendly.

### `usermod`
- Typical command to edit/change the user accound information after you created it.use
- `usermod -aG` GROUP USERNAME` is a typical way to add the USER into GROUP. (a: append, G: groups)
- `usermod -d /home/USERNAME USERNAME`: change user's home directory.
- `usermod -l NEWLOGINNAME OLDLOGINNAME`: change the loging name of the user.

### `/etc/sudoers`

### `su`

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
usermod
chmod
chown
chgrp
