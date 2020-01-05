#
# Packer Build Automation
#
#
-include Makefile.in/feature_flags.mk
-include Makefile.in/push.mk
-include Makefile.in/setup.mk
-include Makefile.in/packer.mk
-include Makefile.in/linters.mk
-include Makefile.in/fetch-all.mk
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
	@echo 'make setup                     :  ...to setup your local environment (from scratch).'
	@echo 'make list                      :  ...to list the available boxes you can build.'
	@echo 'make lint                      :  ...to execute the linters on the project repository.'
	@echo 'make fetch/all                 :  ...to fetch all assets (fetch-*)'
	@echo 'make fetch/iso                 :  ...to fetch the iso files listed in assetts/manifest.yml.'
	@echo 'make fetch/windows             :  ...to fetch the windows files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/deb           :  ...to fetch the linux/deb files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/rpm           :  ...to fetch the linux/rpm files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/src           :  ...to fetch the linux/src files listed in assetts/manifest.yml.'
	@echo 'make fetch/macos               :  ...to fetch the macos files listed in assetts/manifest.yml.'
	@echo ' '
	@echo 'make [feature-flags] clean     : ...to clean up old boxes, run...'
	@echo 'make [feature-flags] list-boxes: ...to list the boxes we have built.'
	@echo 'make [feature-flags] <opsys>   : ...to create a box with the given operating system config.'
	@echo 'make [feature-flags] push      : ...to push the set of all boxes created to local/remote stores.'
	@echo ' '
	@echo '   feature-flags:'
	@echo '     on/*'
	@echo '        on/virtualbox                      : Builds for Virtualbox virtual machines.'
	@echo '        on/vmware (not implemented)        : Builds for VMware virtual machines.'
	@echo '        on/parallels (not implemented)     : Builds for Parallels virtual machines.'
	@echo '        on/aws (not implemented)           : Builds for the AWS platform.'
	@echo '        on/azure (not implemented)         : Builds for the Azure platform.'
	@echo '     to/*'
	@echo '        to/local                           : Targets a local vagrant for push operations (vagrant box add)'
	@echo '        to/vagrantup (not implemented)     : Targets vagrantup (remote) for push operations.'
	@echo '      use/*'
	@echo '        use/force                          : Adds --force to be used in commands.'
	@echo ' '
	@echo 'make [feature-flags] all                   : ...to make clean and run against all your boxes.'
	@echo '                                           :    (and probably heat your home).'
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

