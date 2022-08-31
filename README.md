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

### `newgrp`
- Reflect the new group setting


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
- `usermod -aG GROUP USERNAME` is a typical way to add the USER into GROUP. (a: append, G: groups)
- `usermod -d /home/USERNAME USERNAME`: change user's home directory.
- `usermod -l NEWLOGINNAME OLDLOGINNAME`: change the loging name of the user.

### `su`
- `su` is short for `switch user`. Not for `super user`.
- It's a simplest command to switch to another account during the current session.
- `su -l USERNAME` or `su - USERNAME`: Login to other user account
- `sudo su`: login as a root ".profile", ".bashrc" and "/etc/profile" will be started.
- `su`: It will try you to login to a root account but usually it will not work since root account is locked.

#### How to login as a root?
- `sudo -i`: Run shell as a root with reading environment files. But not directly interacting with the root user.
- `sudo su`: Run shell as a root with reading environment files.
- `sudo -s`: Run shell as a root without reading any environment files.

#### How to give sudo priviledge to the user?
- Two ways
- 1. `sudo usermod -aG sudo USERNAME`
- 2. Edit `/etc/sudoers` and add `USERNAME ALL=(ALL:ALL) ALL`
 
### `/etc/sudoers`
- The file that is used to determine if a user has permission to run commands that require elevated privileges (like the commands in /sbin).
- `root    ALL=(ALL:ALL) ALL`: root user have fill sudo privileges.
- `USERNAME ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/whoami`: USERNAME can run `apt` and `whoami` with sudo privileges.

### `/sbin`
- For the binaries usaable vefore the `/usr` partition is mounted, and for binaries with superuser privileges required.

#### what is the difference between `/bin`, `/sbin`, `/usr/bin`, `/usr/sbin`, `/usr/local/bin`, `/usr/local/sbin`
- `/bin` : For binaries usable before the /usr partition is mounted. This is used for trivial binaries used in the very early boot stage or ones that you need to have available in booting single-user mode. Think of binaries like cat, ls, etc.
- `/sbin` : Same, but for binaries with superuser (root) privileges required.
- `/usr/bin` : Same as first, but for general system-wide binaries.
- `/usr/sbin` : Same as above, but for binaries with superuser (root) privileges required.
- For the binaries that is none of the above. You should use `/usr/local/bin` or `/usr/local/sbin` for system-wide available scripts.
- The local path means it's not managed by the system packages.


## Ubuntu commands/root_files related to host name

### `/etc/hosts`
- Lookup table for hostname.
- You can add new hostname by adding new line. `XXX.XXX.XXX.XXX <canonical_hostname>`

### `/etc/hostname`
- it just contain the name of this machine.

### `hostname`
- `hostname`: lookup `/etc/hostname` and print the name of this machine.
- `hostname -i`: gives the ip addresses of host machine by looking up `/etc/hosts`.
- `hostname -I`: gives the all ip addresses of this machine by looking up `/etc/hosts`.
- `hostname -f`: print a fully qualified domain name (FQDN) by looking up `/etc/hosts`

## Ubuntu commands/root_files related to dpkg and apt

### `/etc/apt/sources.list.d`
- Using the directory, you can easily add new repositories without the need to edit the central `/etc/apt/sources.list` file.
- You can just put a file with a unique name and the same format as `/etc/apt/sources.list` into this folder and it is used by apt.
- 

### `apt-get`
- installation of new software packages, removing existing software packages, upgrading of existing software packages.
- `apt-get update`: Resynchronize the package index files from the their sources specified in /etc/apt/sources.list file. The update command fetched the packages from their locations and update the packages to newer version.
- `apt-get upgrade`: Upgrade all the currently installed software packages on the system. Under any circumstances currently installed packages are not removed or packages which are not already installed neither retrieved and installed to satisfy upgrade dependencies.
- `apt-get remove PKGNAME`: To un-install software packages without removing their configuration files (for later re-use the same configuration).
- `apt-get purge PKGNAME`: To remove software packages including their configuration files.
- `apt-get clean`: Used to free up the disk space by cleaning retrieved (downloaded) .deb files (packages) from the local repository. This command removes everything but the lock file from `/var/cache/apt/archives` and `/var/cache/apt/archives/partial`.
- `apt-get autoremove PKGNAME`: The ‘autoremove‘ sub command is used to auto remove packages that were certainly installed to satisfy dependencies for other packages and but they were now no longer required.

### `apt-get install`
- `apt-get install PKGNAME=VERSION`: Install particular package with certain version. You can use wildcard by making it a string. "*PKGNAME"
- `apt-get install PKGNAME --only-upgrade`: it does not install new packages but it only upgrade the already installed packages and disables new installation of packages.
- `apt-get install -f`: Attempt to correct a system with broken dependencies in place.
- `apt-get install --reinstall PKGNAME` reinstall the pkg.

### `apt-cache`
- command only for searching and collecting the information of packages.
- `apt-cache search PKGNAME`: Show all the packages that has PKGNAME in the description.
- `apt-cache pkgnames PKGNAME`: will show the available packages start with PKGNAME
- `apt-cache show PKGNAME`: Show the detail description of the PKGNAME

### `apt`
- Gathered command of `apt-get` and `apt-cache`.

| apt command | the command it replaces | function of the command |
| ----------- | ----------- | ------------|
| apt install | apt-get install | Installs a package |
| apt remove  | apt-get remove  | Removes a package |
| apt purge   | apt-get purge   | Removes package with configuration |
| apt update  | apt-get update  | Refreshes repository index |
| apt upgrade | apt-get upgrade | Upgrades all upgradable packages |
| apt autoremove  | apt-get autoremove  | Removes unwanted packages |
| apt full-upgrade  | apt-get dist-upgrade  | Upgrades packages with auto-handling of dependencies |
| apt search | apt-cache search | Searches for the program |
| apt show  | apt-cache show  | Shows package details |
| apt list | N/A | lists packages with criteria. `apt list --installed`, `apt list --upgradable` |
| apt edit-sources| N/A | dits sources list |

## Ubuntu commands/root_files related to realtime kernel

### `/etc/security/limits.conf`

## Ubuntu commands/root_files related to Xserver

### `/etc/X11`

### `xhost`

### `xinit`

### `/opt`
Place to keep additional thrid-party software. ROS is here.

# Ubuntu command related to user, group, super user
chmod
chown
chgrp

which
whereis
whatis
locate
