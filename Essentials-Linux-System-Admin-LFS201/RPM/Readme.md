# RPM 

[Home](/README.md)

## Things you want to understand how to do

* Understand how the RPM system is organized and what major operations the rpm program can accomplish.

* Explain the naming conventions used for both binary and source rpm files.

* Query, verify, install, uninstall, upgrade and freshen packages.

* Grasp why new kernels should be installed, rather than upgraded.

* Use `rpm2cpio` to copy packaged files into a `cpio` archive, as well as to extract the files without installing them.

## Advantages of using RPM

* All files related to a specific task or a subsystem are packaged into a single file, which also contains information about how and where to install and uninstall the files. 

* when a new version of a program is released, a new RPM package is usually released too

* these files may not work for other Linux Distros

* Unless RPM is given a URL, it will not by itself install anything over the network

* RPM will default to using the local machine using absolute or relative paths

### For System Admins

* RPM makes it easier to manage software packages

* it makes easy to pick out versions and whether it was installed correctly

* it also makes it easy to uninstall packages

### For developers

* RPM keeps the builders for its target distro separate from the Source Code

* thus it easier to maintain the changes in to code

* additionally since all the build information is located in one place