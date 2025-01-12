vtemplates README
=================

This project consists of various templates for quicker development with Visual
Studio Code.

It currently targets C, C++ and Zephyr development but can include other
platforms as well.

How it works
============

Visual Studio Code is a powerful editor with various extensions but the more you
go into native development the more you have to configure tasks and run
configurations over and over.

However, even though tasks.json and launch.json files can read user
configuration files and reference environment variables they are still not
flexible enough to provide a generic all-in-one solutions. As such, in this
project the key idea is that template files are generated with as much as
possible usable defaults and the developer just need to copy an appropriate
directory and start over.

Unfortunately, depending on the platform and preferences it's still sometimes
not enough. To address this issue, the repository is made up of templates
substituted using make macros. This means that you can re-create all templates
with pre-defined set of variables of your own rather than copying a directory
and edit it again and again.

Usage
=====

The source repository does not contain pre-built templates. Use the generated
release files instead.

To build templates, use GNU make (version >= 4) as following:

    $ make

The result will be generated in `dist` directory.

To build on Windows, uses either MSYS2, Git Bash, WSL or any compliant
environment that includes basic shell with POSIX command line utilities (sed,
echo and so on).

Pass WIN32=1 as make macro to include various system tweaks.

    $ make WIN32=1

Note: GNU sed is required for now.
