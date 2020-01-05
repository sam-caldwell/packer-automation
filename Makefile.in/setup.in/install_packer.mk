#
# Makefile.in/setup.in/install_packer.mk
# Installs packer for windows, linux and macos hosts
#
install-packer-macos:
	@echo "Installing packer for macos"
	@curl https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_darwin_amd64.zip --output packer.zip
	@unzip packer.zip || exit 1
	@mv packer $HOME/.bin/
	@rm packer.zip

install-packer-linux:
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

install-packer-windows:
	@echo "installing packer for windows."
	@echo "This needs testing.  It's disabled for now."
	exit 1
	URL=https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_windows_amd64.zip
