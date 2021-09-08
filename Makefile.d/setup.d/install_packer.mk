#
# Makefile.in/setup.d/install_packer.mk
# Installs packer for windows, linux and macos hosts
#
install-packer-macos:
	@echo "Installing packer for macos"
	@curl https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_darwin_amd64.zip --output packer.zip
	@unzip packer.zip || exit 1
	@mv packer $HOME/.bin/
	@rm packer.zip

install-packer-linux:


install-packer-windows:
