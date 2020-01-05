# Packer Build Templates for Vagrant (Windows, MacOs, Linux)

## Introduction

This repository contains templates that can be used to create boxes for Vagrant using Packer ([Website](http://www.packer.io)) 
([Github](http://github.com/mitchellh/packer)).  This is a fork of the original Windows Packer template repo created 
by [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows). 

## Supported Operating Systems
To see what systems are currently supported, run
```bash 
make list
```

See also...

* [Notes about Supported Windows Environments](./docs/windows/notes_about_supported_environments.md)

* [Notes about Supported MacOs Environments](./docs/macos/notes_about_supported_environments.md)

* [Notes about Supported Linux Environments](./docs/linux/notes_about_supported_environments.md)
 
## Getting Started
The intent of this section is to automate everything from setup to finish using a single `Makefile`.  
The idea is to keep this elegant and easy to use.

First you'll need to install some [required software](docs/required_software.md).  Run `make setup` and you're done.

From time to time, you'll want to reset the environment.  Use `make clean` to do this.

Use `make help` to learn about the commands available in this system.

#### Building Vagrant Boxes
Ready to build a Vagrant box?  Run this...
```
make <opsys_name>
```

To find out what boxes the system will let you build...
```bash 
make list
```

#### Other Documentation

* [Adding a New Environment (OpSys) to the Project](docs/adding_new_box.md)

* [How to enable RSync for Windows Templates](docs/enable-rsync-for-windows-templates.md)


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
