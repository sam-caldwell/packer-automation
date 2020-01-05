# Packer Build Templates for Vagrant (Windows, MacOs, Linux)

## Introduction

This repository contains templates that can be used to create boxes for Vagrant using Packer ([Website](http://www.packer.io)) 
([Github](http://github.com/mitchellh/packer)).  This is a fork of the original Windows Packer template repo created 
by [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows). 

## Supported Operating Systems
### Windows 
See [Notes about Supported Windows Environments](./docs/windows/notes_about_supported_environments.md)
 * Windows 2012 R2
 * Windows 2012 R2 Core
 * Windows 2012
 * Windows 2008 R2
 * Windows 2008 R2 Core
 * Windows 10
 * Windows 8.1
 * Windows 7

### MacOs
See [Notes about Supported MacOs Environments](./docs/macos/notes_about_supported_environments.md)
 * MacOS High Sierra (planned)
 * MacOS Mojave (planned)
 * MacOS Catalina (planned)

### Linux
See [Notes about Supported Linux Environments](./docs/linux/notes_about_supported_environments.md)
  * Ubuntu 18.04 (planned)
  * Gentoo (planned)
 
## Getting Started
The intent of this section is to automate everything from setup to finish using
a single `Makefile`.  The idea is to keep this elegant and easy to use.

### Installing Required Software
This section will help install all you need for a local environment:
#### Get Help
```bash 
make help
```
#### Software Requirements
* [Packer](https://github.com/mitchellh/packer/blob/master/CHANGELOG.md) `1.5.1` or greater is required.
* [Virtualbox](https://www.virtualbox.org/) <= `6.0`  (As of 4 Jan 2020, Version 6.1 and later do not work with vagrant).
* [Vagrant](https://www.vagrantup.com/downloads.html) `2.1.1`

```bash
make setup
```

#### Clean up existing boxes
This will clean up any existing boxes that have been built (in the `./box` directory)
```bash
make clean
```

#### Build a New Box
Ready to build a Vagrant box?  Run this...
```
make <opsys_name>
```
Here we just specify the target (e.g. win10 to build a Windows10 box) and
we're free to go get a cup of coffee.

#### Other Documentation

* [Adding a New Environment (OpSys) to the Project](docs/adding_new_box.md)



### Contributing
* Pull requests welcomed.

### Acknowledgements

* Thanks to [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows) for the work on his original 
  repo which I am extending.  Joe, we've never met, but the next time you're in Austin, Texas, I owe you a 
  breakfast taco for saving me a lot of work here.

* From the original repo by Joe Fitzgerald, we have the following acknowledgements:

  * This repo began by borrowing bits from the [VeeWee Windows templates](https://github.com/jedi4ever/veewee/tree/master/templates). 
    Modifications were made to work with Packer and the VMware Fusion / VirtualBox providers for Packer and Vagrant." 

  * [CloudBees](http://www.cloudbees.com) is providing a hosted [Jenkins](http://jenkins-ci.org/) master through
    their CloudBees FOSS program. We also use their [On-Premise Executor](https://developer.cloudbees.com/bin/view/DEV/On-Premise+Executors) feature
    to connect a physical [Mac Mini Server](http://www.apple.com/mac-mini/server/) running VMware Fusion.

  * ![Powered By CloudBees](http://www.cloudbees.com/sites/default/files/Button-Powered-by-CB.png "Powered By CloudBees")![Built On DEV@Cloud](http://www.cloudbees.com/sites/default/files/Button-Built-on-CB-1.png "Built On DEV@Cloud")
