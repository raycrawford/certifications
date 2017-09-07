# Finding what version
* `cat /etc/system-release`
* `lsb_release -d`
* `uname -r`
* `cat /proc/version`
* `cat /proc/cmdline`

# Shutting down
* `shutdown -r 10 "Message to display"`
  * Blocks login at T-50%
* `reboot`
* `poweroff`

## Finding and setting run levels
* `systemctl get-default`
* `systemctl set-default multi-user.target` (txt login)
* 

# GRUB & Linux boot process
## Enabling recovery mode
* Hit ESC during GRUB boot
* Search for linux16 line and use ctrl + e to edit, appending systemd.unit=rescue.target to that line to get into rescue mode

* `vi /etc/default/grub`
* Set `GRUB_DISABLE_RECOVERY="false"`
* Regenerate grub configs `grub2-mkconfig -o /boot/grub2/grub.cfg`

## Reset lost root password
* Boot to the iniramfs
    * edit group procces
    * look for the linux16 line
    * remove `quiet` and `rhgb` options
    * add in `rd.break` and selinux `enforcing=0` options
    * mount the root FS `mount -o remount,rw /sysroot`
    * `chroot /sysroot`
    * `passwrd`
    * `exit`
    * When done, mount the root fs as read only again `mount -o remount,ro /sysroot` and `exit` out of the bootloader
    * when it boots, `restorecon /etc/shadow` and `setenforce 1`

Now all's good again...

# Install, configure & troubleshoot the bootloader
* `grub2-install /dev/sda`
* You can alter some of the options with `grubby`

# Change kernel runtime parameters, persistent and non-persistent
* you can set unencrypted and encrypted passwords for the grub boot loader...
* `vi /etc/grub.d/01_users`
* add: 
  `set superusers="andrew"`
  `password andrew L1nux`

# Managing Linux Processes
* `ps --forest` or `ps -elf` or `ps aux`
* `cd /proc/$$`
* `stty -a` gives us keyboard shortcuts
* `pgrep` uses regex to search processes

# Process priority
* nohup runs processes in the background
* nice ranges -20 to +19
  * Default is 0
  * standard users can't renice to higher priority

# Monitoring Linux Performance
* cool tools to find out what's provided:
  * `rpm -qf /usr/bin/ps`
  * `rpm -ql procps-ng`
  * `rpm -ql procps-ng | grep '^/usr/bin/'`

# Using sysstat to monitor performance
Produce and deliver reports...
* Installing
  * yum install -y sysstat
* Managed via crontab: `cat /etc/cron.d/sysstat`
* Parameters are stored in /etc/sysconfig/sysstat
* Need to start and enable it
  * `systemctl start sysstat`
  * `systemctl enable sysstat`
* provides:
  * iostat
  * pidstat
  * mpstat

# Creating System Activity Reports
* `sar -s 14:50:00 -e 15:10:00 -f /var/log/sa/sa15`
  * looks at the data from the 15th day of the rotation during that time frame

# Managing Shared Libraries
* `ldd /usr/bin/ls`
* `pmap $$` gives a list of the shared libraries loaded in the current shell

I didn't focus on this subject, but I believe it's a bit too obscure to be hammered on in the exam.




