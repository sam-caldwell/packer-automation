#
# Packer Build Automation
#
#
-include Makefile.in/setup.mk
-include Makefile.in/packer.mk
-include Makefile.in/vagrant-add-box.mk
-include Makefile.in/windows/Makefile
-include Makefile.in/macos/Makefile
-include Makefile.in/linux/Makefile

PATH += $HOME/.bin

.DEFAULT_GOAL := help

help:
	@echo 'Packer build automation Makefile'
	@echo ' '
	@echo 'Usage'
	@echo ' '
	@echo 'make setup     : ...to setup your local environment (from scratch).'
	@echo 'make list      : ...to list the available boxes you can build.'
	@echo ' '
	@echo 'make [feature-flags] clean     : ...to clean up old boxes, run...'
	@echo 'make [feature-flags] list-boxes: ...to list the boxes we have built.'
	@echo 'make [feature-flags] <opsys>   : ...to create a box with the given operating system config.'
	@echo 'make [feature-flags] add-local : ...to run vagrant box add and add your machines to your local vagrant.'
	@echo ' '
	@echo '   feature-flags:'
	@echo '      on-virtualbox (not implemented)'
	@echo '      on-vmware (not implemented)'
	@echo '      on-parallels (not implemented)'
	@echo '      on-aws (not implemented)'
	@echo '      on-azure (not implemented)'
	@echo '      to-vagrantup (not implemented)'
	@echo ' '
	@echo 'make all       : ...to make clean and run against all your boxes. (and probably heat your home).'
	@echo ' '
	@echo 'documentation: https://github.com/sam-caldwell/packer-automation'
	@echo ' '

clean:
	@echo "Cleaning..."
	@rm -rf ./packer_cache &> /dev/null
	@rm -rf ./output-virtualbox* &> /dev/null
	@rm -rf ./output-vmware &> /dev/null
	@rm -rf ./output-parallels &> /dev/null
	@rm -rf ./packer_cache &> /dev/null
	@rm -rf ./box/ &> /dev/null
	@mkdir -p ./box/{windows,macos,linux}

list:
	@find ./packer/ -name "*.json" -type f | sed -e 's/\.\/packer\/\//- /' | sed -e 's/\.json//' | sort

list-boxes:
	@find ./box/ -name "*.box" -type f | sed -e 's/\.\/box\/\//- /' | sed -e 's/\.box//' | sort

hash:
	@rm ./iso/hashes.txt
	@find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;

.PHONY: all
all:
	@echo 'Executing everything...this is gonna take a long time.'
