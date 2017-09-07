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
* `lsb` provides a listing of block devices
* `lsblk` provides more output
* `ls -l /dev/sda*` - the leading "b" means that's a block file
  * A leading "l" means it's a link
* `-d` on ls shows the metadata on the file
* Use `rpm -qf /usr/bin/lsb_release` to find out what package a file comes from

### Types of files:
* Regular files (-)
* Directories (d)
* Symbolic links (l)
* Block devices (b)
* Character devices (c)
  * TTYs
* Named pipes (p)
* Sockets (s)

## Create hard and soft links
* The 2nd column of `ls -ld <directory>` is the number of hard links to that item.  Can this only be done to directories?
* minimum number of hard links is 2; one for the directory and one for the . reference.

# Module 5; Reading files
## General
* `head -n 5 /etc/hosts`
* `tail -n 5 /etc/hosts`
* `less` looks at a file from the bottom where as `more` looks at a file from the top
* grep --color=auto ...  colors the things you searched for
* tail -n1 <file>

## Analyze text using regular expressions
* sudo yum install -y words
* grep -E '[aeiou]{5}' /user/share/dict/words
```
fucntion clean_file {
  sed -i '/^#/d;/^$/d' $1
}
```
* interesting...  `sed command 1;sed command 2' using the first arg to the function, $1

## Comparing text files
* diff <= text files

## Comparing binary files
* md5sum <= binary files

## Manipulate file content programmatically
* sed -i s/a/b/g

## Search for files
* find can -delete

# Module 6; vi
## touch
* synonomous with `> newfile.txt`
* stat command is pretty cool
* touch -d can update the access and modify time..

## nano
* nothing too interesting there...

## vim
'Editing files with vim' is pretty interesting...  not too useful for the exam, I don't think, but interesting.

### Commands
* Capital G takes you to the bottom of the file
* 1G takes to the top of the file
* i inserts at spot
* I inserts at beggining of line
* A appends at end of line
* yy copies a line
* P pastes above and p pastes below line
* dd deletes line
* 2dd deletes 2 lines
* dG deletes to the end of the file
* deleted lines go into the copy buffer...

### .vimrc file
* set number/nonumber
* set showmode
* commands can be placed all on the same set line or different ones
* set ai ts=4 expandtab
  * <C-D> shifts back to the left one indent
* abbr _sh #!/bin/bash
* nmap <C-N> :set ivnumber<CR> <= Pretty cool!

# Piping and Redirection; Module 7
## Redirecting STDOUT
* df -h 1> file1 # Explicitly states to send to standard out

## Using noclobber
* set -o|+o noclobber
* set -o | grep noclobber
* >| overrides noclobber

## Redirection of STDERR
* >2 redirects STDERR
* find /etc/ -type l 2> /dev/null
* &> sends STDOUT and STDERR to the same place

## Reading into STDIN
  
## Here documents
* cat > myNewFile <<END
  * runs until the "Here" document is found

## Using command pipelines

## Using named pipes
* mkfifo mypipe
* Very cool...  can ship stuff through a pipe between process
* Very simple IPC (interprocess communication)

## Using tee
* ls | tee file89 # Dumps to screen and into file89

# Archiving files

# tar
* not that impressive of a section considering the power of the tool

# compression
* file <file> gives some interesting info about the file
* showed the use of the time command to measure the effectiveness and efficiency of compression

# cpio
* `find -name '*.pdf' | cpio -o > /tmp/pdf.cpio`
* `cpio -id /tmp/pdf.cpio`
  * d creates directories

# dd
* Disk Duplicator
* Insert CDROM image via VirtualBox
  * `dd if=/dev/sr0 of=netinstall.iso`
    * will take the (if) input file from the block device and write it to an (of) of netinstall.iso
    * can then mount those images...
  * You can also wipe devices with this tool
    * `fdisk -l` lists partitions
    * `dd if=/dev/sda of=sda.mbr count=1 bs=512`
      * Backs up the MBR
    * `dd if=/dev/zero of=/dev/sda count=1 bs=512`
      * Zeros out the MBR...  yikes!  :)
    * `dd if=sda.mbr of=/dev/sda` # Don't have to give block count or byte size because it will only write the length of the source file...

# Accessing Command Line Help
## Info pages
* `info ls`

# Understanding file permissions
* USB drives use FAT so they don't have standard permissions
* umask adjusts permissions
  * can use octal masks or symbolics
  * can only remove permissions
* stat -c %a octal
* stat -c %A symbolic

# Access the Root account

# Accessing servers with SSH
* ssh-agent & ssh-add unlocks and caches your creds if you make it use a password when you create the keys

# Using Screen and Script
## Script
* recording sessions and providing collaborative control
* Just type script to start and exit to end
* Holy shit.  That's cool!
  * script -f /tmp/mypipe # starts capture
  * cat /tmp/mypipe # views capture... 

## Screen
* need to install screen...
* Holy shit!  You can use .screenrc to fire up connections on other boxes!!!
```
screen -t master 0 bash
screen -t s1 1 ssh server1
screen -t s2 2 ssh server2
```
* Might need to figure out how to do the ssh thing from the ssh section...
* <C-a n> Next screen
* <C-a p> Previous screen
* <C-a "> Lists all screens
* Holy, holy shit!
  * `:at "#" stuff 'yum install -y zsh^M"`
    * "stuffs" the command into all open sesssions!!!  Fuck yeah!
