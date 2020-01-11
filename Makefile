#
# Packer Build Automation
#
-include Makefile.in/feature_flags.mk
-include Makefile.in/list.mk
-include Makefile.in/clean.mk
-include Makefile.in/setup.mk
-include Makefile.in/build.mk
-include Makefile.in/linters.mk
-include Makefile.in/test/test.mk
-include Makefile.in/fetch-all.mk
-include Makefile.in/list-boxes.mk
-include Makefile.in/push/push-boxes.mk
-include Makefile.in/push/push-assets.mk
-include Makefile.in/macos/Makefile
-include Makefile.in/linux/Makefile
-include Makefile.in/windows/Makefile

PATH += $HOME/.bin

.DEFAULT_GOAL := help

help:
	@echo 'Packer build automation Makefile'
	@echo ' '
	@echo 'Usage'
	@echo ' '
	@echo 'make setup                       :  ...to setup your local environment (from scratch).'
	@echo 'make list                        :  ...to list the available boxes you can build.'
	@echo 'make lint                        :  ...to execute the linters on the project repository.'
	@echo 'make fetch/all                   :  ...to fetch all assets (fetch-*)'
	@echo 'make fetch/iso                   :  ...to fetch the iso files listed in assetts/manifest.yml.'
	@echo 'make fetch/windows               :  ...to fetch the windows files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/deb             :  ...to fetch the linux/deb files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/rpm             :  ...to fetch the linux/rpm files listed in assetts/manifest.yml.'
	@echo 'make fetch/linux/src             :  ...to fetch the linux/src files listed in assetts/manifest.yml.'
	@echo 'make fetch/macos                 :  ...to fetch the macos files listed in assetts/manifest.yml.'
	@echo 'make push/assets                 :  ...to push the assets cache to the remote s3 bucket.'
	@echo 'make test/<opsys>                :  ...to use vagrant to test a local box for the given opsys string.'
	@echo '                                       where 'opsys' is 'windows/10' or macos/highsierra, etc.'
	@echo ' '
	@echo 'make [feature-flags] clean       :  ...to clean up old boxes, run...'
	@echo 'make [feature-flags] list-boxes  :  ...to list the boxes we have built.'
	@echo 'make [feature-flags] <opsys>     :  ...to create a box with the given operating system config.'
	@echo 'make [feature-flags] push/box    :  ...to push the set of all boxes created to local/remote stores.'
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

all:
	@echo "Doing a 'make all' in this project would be a very bad idea unless you were running this on a gibson."
	exit 1

