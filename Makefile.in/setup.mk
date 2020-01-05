#
# Makefile.in/setup.mk
#
# Objectives:
#	- install vagrant
#	- install packer
#	- install virtualbox
#

-include setup.in/install_vagrant.mk
-include setup.in/install_packer.mk
-include setup.in/install_virtualbox.mk

ifeq ($(OS),Windows_NT)
    HOST_OS=windows
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        HOST_OS=linux
    endif
    ifeq ($(UNAME_S),Darwin)
        HOST_OS=macos
    endif
endif

setup:
	@echo 'setting up your local machine'
	@echo 'HOST_OS:$(HOST_OS)'
	@command -v vagrant &>/dev/null || $(MAKE) install-vagrant-$(HOST_OS)
	@command -v packer &>/dev/null || $(MAKE) install-packer-$(HOST_OS)
	@command -v virtualbox &>/dev/null || $(MAKE) install-virtualbox-$(HOST_OS)
