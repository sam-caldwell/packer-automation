include Makefile.d/setup.d/*.mk

help-setup:
	$(call print_help_line,"make setup","Setup your local environment (from scratch).")

setup-banner:
	@echo 'setting up your local machine'
	@echo 'HOST_OS:$(HOST_OS)'

setup: setup-banner \
	   setup-package-manager \
	   setup-vagrant \
	   setup-packer \
	   setup-hypervisor \
	   setup-pip-packages
	@echo "setup complete"

setup-pip-packages:
	pip3 install -r requirements.txt

setup-hypervisor: setup-hv-virtualbox \
				  setup-hv-vmware \
				  setup-hv-hyperv \
				  setup-hv-parallels \
				  setup-hv-kvm \
				  setup-hv-qemu

setup-hv-virtualbox:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep virtualbox | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	#ToDo: use cached objects pulled by make fetch/*
	ifeq ($(HOST_OS),"windows")
		@echo "installing virtualbox for windows."
		URL=https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing virtualbox for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing virtualbox for macos"
		URL=https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-OSX.dmg
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-hv-vmware:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep vmware | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	ifeq ($(HOST_OS),"windows")
		@echo "installing vmware for windows."
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing vmware for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing vmware for macos"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-hv-hyperv:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep hyperv | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	ifeq ($(HOST_OS),"windows")
		@echo "installing hyperv for windows."
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing hyperv for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing hyperv for macos"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-hv-parallels:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep parallels | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	ifeq ($(HOST_OS),"windows")
		@echo "installing parallels for windows."
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing parallels for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing parallels for macos"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-hv-kvm:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep kvm | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	ifeq ($(HOST_OS),"windows")
		@echo "installing kvm for windows."
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing kvm for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing kvm for macos"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-hv-qemu:
ifeq ($(shell cat SUPPORTED_HYPERVISORS.txt | grep qemu | head -n1 | awk -F\: '{print $$2}' | sed -e 's/ //'),"enabled")
	ifeq ($(HOST_OS),"windows")
		@echo "installing qemu for windows."
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"linux")
		@echo "installing qemu for linux"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else ifeq ($(HOST_OS),"macos")
		@echo "Installing qemu for macos"
		@echo "Not implemented.  Please consider contributing this feature."
		@exit 1
	else
		@echo "Unrecognized operating system: $(HOST_OS)"
		@exit 1
	endif
endif

setup-vagrant:
	@echo "Install 'vagrant' ($(HOST_OS))"
ifeq ($(HOST_OS),"windows")
	@brew install vagrant || {\
		@echo "installing vagrant for windows."
		@echo "This needs testing.  It's disabled for now."
		exit 1
		URL=https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.msi
	}
endif
ifeq ($(HOST_OS),"linux")
	@echo "installing vagrant for linux"
	@echo "This needs testing.  It's disabled for now."
	exit 1
	ifeq (, $(shell command -f apt-get))
		apt-get install wget -y
		wget https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
		apt-get install ./vagrant_2.2.6_x86_64.deb
		rm -rf ./vagrant_2.2.6_x86_64.deb
	elif (, $(shell command -f yum))
		yum install wget -y
		wget https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm
		yum install -y ./vagrant_2.2.6_x86_64.rpm
		rm -rf vagrant_2.2.6_x86_64.rpm
	endif
endif
ifeq ($(HOST_OS),"macos")
	@brew install vagrant || {\
		echo "install failed ($(HOST_OS)).";\
		exit 1;\
	}
endif
	@echo ">>completed install of vagrant."

setup-packer:
	command -v packer && exit 0
	@echo "Install 'packer' ($(HOST_OS))"
ifeq ($(HOST_OS),"windows")
	@brew install packer || {\
		echo "install failed ($(HOST_OS)).";\
		exit 1;\
	}
endif
ifeq ($(HOST_OS),"linux")
	@apt-get install -y --no-install-recommends packer || {\
		echo "install failed ($(HOST_OS)).";\
		exit 1;\
	}
endif
ifeq ($(HOST_OS),"macos")
	@echo "installing packer for linux"
	@echo "This needs testing.  It's disabled for now."
	exit 1
	ifeq (, $(shell command -f apt-get))
		apt-get install curl -y
	elif (, $(shell command -f yum))
		yum install curl -y
	endif
	curl https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip --output packer.zip
	@unzip packer.zip || exit 1
	@mv packer $HOME/.bin/
	@rm packer.zip
endif
	@echo ">>completed install of packer."

setup-package-manager:
	@echo "install package manager (brew)"
	@command -v brew && exit 0
ifeq ($(HOST_OS),"windows")
	@echo "setup-package-manager: not yet implemented for $(HOST_OS)."
	@exit 1
endif
ifeq ($(HOST_OS),"linux")
	@echo "setup-package-manager: not yet implemented for $(HOST_OS)."
	@exit 1
endif
ifeq ($(HOST_OS),"macos")
	@command -v brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
endif


