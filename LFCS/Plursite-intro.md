# Exam
* 2 hours
* Taken on a live VM; measures your ability to DO tasks
* Plursite course set on CentOS 7

# Courses
* Linux Essentials
* Linux Operation Essentials
* Linux User and Group Management
* Linux Storage Management
* Linux Networking
* Linux Service Management

# Installing CentOS 7
## Downloads
* Everything: 7 GB
* Full: 4 GB
* Minimal: 600 MB

Steps:
1. Download ISO
   * Net Install is good for installing over the network
1. VB networking
   * You need to create a NAT Network
     * File => Preferences => Network => + Nat Network
     * You can edit the IP block
     * Set it up on 10.10.1.0/24
1. Installing from local media
   * used http://mirrors.kernal.org/centos/7/os/x86_64 as a mirror URL
   * Showed a quick example of using his local web server to install from; did not show how to set up the web server, yet...
   * update packages:
     * make sure nameserver 8.8.8.8 is /etc/resolv.conf
       * Prior to that, I was getting a `Cannot find a valid baseurl for repo: base/7/x86_64`
     * yum update -y
      
1. Adding Active X
     * Install additional packages: `yum install -y redhat-lsb-core net-tools epel-release kernel-headers kernel devel`
       * epel-release repo is needed for GUI packages
       * because this was a minimal install, it didn't include the headers and devleopment libraries
    * Install development tools (including Virtual Box Additions) `yum groupinstall -y "Development Tools"`
    * Install Windows Desktop on one of the servers: `yum groupinstall -y "X Window System" "MATE Desktop"`
      * `systemctl set-default graphical.target`
      * `systemctl isolate graphical.target`

1. Adding Guest Additions
   * Graphical
        * Reboot VMs
        * In VB Device menu, scroll down to the bottom and say, "Insert Virtual Box Additions"
        * If that doesn't work, open a root window, run `mount`, look where the OS Additions thing is mounted and run VBoxLinuxAdditions.run
        * When it's done, reboot and eject the DVD
   * Text
     * Don't know how to do this one yet...

# Module 5
## Identify the component of Linux that a file belongs to
## Log into the GUI and text consoles
   * Physical TTY
   * Local Psuedo TTY
   * Remote Psuedo TTY (SSH)
   * Graphical
     * Right click or top bar gets you a console
     * Control + makes the font bigger
     * Control D shuts the console
     * Control F2 takes you to the physical console (F2 - F6; F1 is used by graphical console) (fn+alt+cntl+[f1-f6] on Mac)

## Create, copy and delete files
## Identify different file types
## Create hard and soft links

Stopped at Module 4: listing files.