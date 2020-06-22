# YUM

[Home](/README.md)

YUM the better way of dealing with packages

* auto resolve dependencies when installing
* updating and removing packages
* external software repos access with synchronization and retrieval of new software as needed

In order to be successful you should know how to do the following:

* Discuss package installers and their characteristics.
* Explain how yum works as a high-level package management system.
* Configure yum to use repositories.
* Discuss the queries yum can be used for.
* Verify, install, remove, and upgrade packages using yum.
* Learn about additional commands and how to install new repositories.
* Understand how to use dnf, which has replaced yum on Fedora.

## Package installers

High level package managers like `yum dnf apt zypper` use databases and software to function much more intelligently than the low level package managers. Here are some examples:

* Can use both local and remote repositories as a source to install and update binary, as well as source software packages.

* Are used to automate the install, upgrade, and removal of software packages.

* Resolve dependencies automatically.

* Save time because there is no need to either download packages manually or search out dependency information separately.


## What is YUM

* `yum` is the front end to `rpm`

* primary task : fetch packages from multiple remote repose and resolve depending among packages 

* used in RHEL CentOS Sci-linux and Fedora

* yum uses a cache to speed things up

* to clean up the cache run `yum clean [ packages | metadata | expire-cache | rpmdb | plugins | all ]`

* yum has a number of plugins and companion programs that can be found under `/usr/bin/yum*` and `/usr/sbin/yum*`.

## Queries

* `yum` does what `rpm` does but better -- with the ability to search remote repos

* Search functionality:
  * `sudo yum search keyword` -- gives more info about the packages
  * `sudo yum list "*keyword*"` -- what is installed vs what is availble

* Detailed info:
  * `sudo yum info package`

* List pakages:
  * `sudo yum list [installed | updates | available]`

* show package groups:
  * `sudo yum grouplist [group1] [group2]`
  * `sudo yum groupinfo group1 [group2]`

* show packages to contain a certain file name
  * `sudo yum /path/to/file`

## Verifying Pcakges

*package verification requires the installation of `yum-plugin-verify` package!!*

* Run `sudo yum install yum-plugin-verify`

* to verify run
  * `sudo yum verify [package]`

* to mimic  `rpm -V` exactly run
  * `sudo yum verify-rpm [package]`

* to list the diffs, including config files
  * `sudo yum verify-all [package]`

NOTE: *`dnf` does not have an equivalent verify plugin command or option*

## Installing / Removing / Upgrading Packages 

* to install and resolve package dependencies
  * `sudo yum install package`  -- like sudo yum install docker

* to install from a local `rpm`
  * `sudo yum localinstall package-file`
  * *note: this is not the same as running the `rpm` version*
  * `yum` will try to resolve dependencies by accessing remote repositories

* to install a software group from repo
  * `sudo yum groupinstall group-name`
  * `sudo yum install @group-name`

* remove package
  * `sudo yum remove package`
  * *note: don't run with -y as it will auto confirm and delete package dependencies to, which may not be what you are trying to do* 