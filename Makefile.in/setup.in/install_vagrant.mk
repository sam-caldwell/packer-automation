install-vagrant-macos:
	@echo "Installing vagrant for macos"
	curl https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.dmg
	hdiutil attach ./vagrant_2.2.6_x86_64.dmg
	hdiutil detach ./vagrant_2.2.6_x86_64.dmg

install-vagrant-linux:
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

install-vagrant-windows:
	@echo "installing vagrant for windows."
	@echo "This needs testing.  It's disabled for now."
	exit 1
	URL=https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.msi
