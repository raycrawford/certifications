# Essential Commands

## <a name="component_file_belongs_to"></a>Identify the component of the Linux distribution that a file belongs to

### With RPM

`rpm -qf <package>`
* For example `rpm -qf /bin/ls`
* -q = query
* -f = file

### With dfn

`dfn provides /bin/ls`
* dfn is the next generation yum; called 'Dandified Yum'

### With yum

`yum provides /bin/ls`

## <a name="graphical_and_text_mode_consoles"></a>Log into graphical and text mode consoles

### Switching from within graphical mode:

* Switch to text mode: CTRL + ALT + F1
* Switch to graphical mode: CTRL + ALT +F7

### Booting into text mode

* To set multi-user mode: `systemctl set-default multi-user.target`
* To set graphical mode: `systemctl set-default graphical.target`

This is different than the old initd thing; now handled by systemd.  To get current default, use `systemctl get-default`

## <a name="search_for_files"></a>Search for Files

This is done using the `find` command, of course.  Some useful flags are:

`-type`
* Searches for a file-system entity of a particular type; options include:
  * `f` = regular files
  * `d` = directories
  * `l` = links
  * Interestingly, you can search for sockets (s) and maned pipes (p), too...

`-uid` or `-user`
* uid is the UID and user can be the username or UID

`-prune`
* Exclude a directory

`-exec <command> {} \;
* Super badass alternative is `-exec <command> {} +` which builds all the matches and runs the command **once**!
* The exec command runs from the current directory; to run from the directory containing the match, use `-execdir`

`-size`
* add 'M' for megabytes and 'G' for gigabytes
* weirdness based upon sparseness of file

`-perm <mode>`
* Accepts octal or text modes

## <a name="create_and_edit_text_files"></a>Create and edit text files

There are many text editors available in Linux.  Some of the more popular ones include:

### nano (text)
* Uses CTRL sequences, a lot
* CTRL-G gets you help
* Set up a lot like vi
* Cool thing... hitting escape 2 times puts you in a mode where you can enter asci values from 0 => 255 and nano will put that character in the cursor location

### gedit (graphical)

### vi

### emacs

I've not used this, but it seems really full featured...  Oye, to exit, type CTRL-x, CRTL-c.

### cat and echo

When all else fails, you can cat or echo into a file... ;)

## <a name="using_input_output_redirection"></a>Use input-output redirection (e.g. >, >>, |, 2>)

A good explaination is provided by [Digital Ocean](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-i-o-redirection).

There are three streams:
* standard input (stdin)
* standard output (stdout)
* standard error (stderr)

They are numbered 0, 1 and 2, respectively.

There are redirection operators:
* < (stdin)
* \> (stdout)
* \>> append to stdout
* 2> create stderr
* etc...
* 2>&1
  * redirects stderr to stdout; 2>1 would send it to a file
  * & tells it 1 is a file descriptor rather than a file

You can also pipe `|` output to other programs.  If stdout or stderr is redirected to /dev/null, it disappears.  It's a special file used to trash any streams.

**A little trick:** `tee` provides a teed pipe.  It will dump what is sent to it to disk while passing along the output through the pipline.

* Example: `ls | tee 'theLog.txt | less`

## <a name="analyze_text_with_regex"></a>Analyze text using basic regular expressions

### grep

Using grep, pass the `-E` flag to leverage regexes like `grep -E '^Bat'`.  A good explanation can be found [here](https://www.ibm.com/developerworks/aix/library/au-speakingunix9/index.html).

* Groups can be searched like: `grep -E '^[bcBC]at'`
* Ranges of matches can be done with {} like: `grep -E '^[A-z][A-z0-9]{2,7}'`

### sed

* [A super-awesome tutorial](http://www.grymoire.com/Unix/Sed.html)
* "Stream EDitor"
* `sed 's/day/night/' < old > new`
* `&` corresponds to the matched pattern; `sed 's/[a-z]*/It Goes Here => (&) <= In parens/'`
* Parenthesis (in the pattern) and \1, \2, etc in the substitution are used to replace multiple pieces
* Check out the -e (multi-commands) with the w option to split a file into up to 10 different streams!  Pretty cool...

### awk

AWK is a programming language designed for text processing and typically used as a data extraction and reporting tool. It is a standard feature of most Unix-like operating systems.  It is probably far more complex than what is needed in the scope of this section...

See [this book](https://www.gnu.org/software/gawk/manual/gawk.html) if you're looking for more information.

### tr

* Just translates from one set of characters to another: `tr 'abcd' 'jkmn'`
* `tr -s '\n'` will truncate all multiple lines into one (neat)...
* `tr -d '\r'` will delete all carriage returns

## Create, delete, copy, and move files and directories
<a name="create_delete_copy_move_files_directories"></a>

### mkdir
* -p to make parent directories for deep-nested creation requests
* --context= (-Z) to set the SELinux security context of the created directory; -Z sets the type to the default
* -m (in umask syntax) to create the directories with a particular permission

### cp
* -r for directories
* -p to preserve permissions
* -l to link to hard link to file rather than copying them
* -f forces the copy
* -n preserves files in the destination
* -u updates the destination file only if the source is newer
* -L follows links
* --sparce=[auto|always|never] controls the creation of sparce files

## rm
* -r for recursive, necessary for directories
* don't do `rm -r ./.*`; that would be BAD!!! :)

## tar
* tar -cvfz tecmint-14-09-12.tar.gz /home/tecmint/
   * create tar
   * make a file called <file>
   * gzip it
     * j bzip2's it
* tar -tvf uploadprogress.tar
  * list the contents of a tar
  * x (instead of t) expands it
  * gzip's and bzip2's are automagically expanded before unarchiving and they also can be searched the same as tarballs
* tar -xvf cleanfiles.sh.tar cleanfiles.sh
  * extract one file
  * to do gzips and bzip2's you must add the z or j to extract one (or all) file(s)
* tar -xvf tecmint-14-09-12.tar "file 1" "file 2" 
* tar -xvf Phpfiles-org.tar --wildcards '*.php'
* tar -rvf Phpfiles-org.tar this.file
  * Adds 'this.file' to the tar
  * Can't do this to gzip's or bzip2's in one step...
* tar xvf - . | (cd /here/and/there && tar cvf -)
* tar can use the --sparce option to detect and take out sparce spots in files; on expansion, the files are made sparce, again

## Create hard and soft links
<a name="create_hard_and_soft_links"></a>

You would certainly use copies for backup and also for test purposes where you want to try out a new program without putting your operational data at risk. You use links when you need an alias for a file (or directory), possibly to provide a more convenient or shorter path. In the next section, we'll look at some other uses for links.

### Hard Links

`ln <file> <link>`

* Hard links can not be invalid because if the underlying file is deleted, so is the link
* Hard links can only reference files; they can not reference directories of files across file systems as the inode reference would be incomplete

### Soft Links

`ln <file> <link>`

* Can referece directories and span file systems
* The current working directory should be link destination

### find and links

`find -l`
* find symbolic links

`find <file> -samefile`
`find <path> -inum XXXX`
* Finds all files that link to file or all files in <path> that link to file with inode <XXXX>
