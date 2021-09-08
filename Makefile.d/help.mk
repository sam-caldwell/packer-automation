.PHONY:=help, banner

help-banner:
	@echo 'Packer Automation'
	@echo ' '
	@echo 'Usage'
	@echo ' '

help: help-banner \
	  help-setup \
	  help-list \
	  help-list-boxes \
	  help-lint
	@echo ""
	@printf "\nVersion: $(shell cat VERSION.txt | head -n 1)\n$(shell cat COPYRIGHT.txt | head -n 1)\n\n"

#	@echo 'make fetch/all                 :  ...to fetch all assets (fetch-*)'
#	@echo 'make fetch/iso                 :  ...to fetch the iso files listed in assetts/manifest.yml.'
#	@echo 'make fetch/windows             :  ...to fetch the windows files listed in assetts/manifest.yml.'
#	@echo 'make fetch/linux/deb           :  ...to fetch the linux/deb files listed in assetts/manifest.yml.'
#	@echo 'make fetch/linux/rpm           :  ...to fetch the linux/rpm files listed in assetts/manifest.yml.'
#	@echo 'make fetch/linux/src           :  ...to fetch the linux/src files listed in assetts/manifest.yml.'
#	@echo 'make fetch/macos               :  ...to fetch the macos files listed in assetts/manifest.yml.'
#	@echo ' '
#	@echo 'make [feature-flags] <opsys>   : ...to create a box with the given operating system config.'
#	@echo 'make [feature-flags] push      : ...to push the set of all boxes created to local/remote stores.'
#	@echo ' '
#	@echo '   feature-flags:'
#	@echo '     on/*'
#	@echo '        on/virtualbox                      : Builds for Virtualbox virtual machines.'
#	@echo '        on/vmware (not implemented)        : Builds for VMware virtual machines.'
#	@echo '        on/parallels (not implemented)     : Builds for Parallels virtual machines.'
#	@echo '        on/aws (not implemented)           : Builds for the AWS platform.'
#	@echo '        on/azure (not implemented)         : Builds for the Azure platform.'
#	@echo '     to/*'
#	@echo '        to/local                           : Targets a local vagrant for push operations (vagrant box add)'
#	@echo '        to/vagrantup (not implemented)     : Targets vagrantup (remote) for push operations.'
#	@echo '      use/*'
#	@echo '        use/force                          : Adds --force to be used in commands.'
#	@echo ' '
#	@echo 'make [feature-flags] all                   : ...to make clean and run against all your boxes.'
#	@echo '                                           :    (and probably heat your home).'
#	@echo ' '
#	@echo 'documentation: https://github.com/sam-caldwell/packer-automation'
#	@echo ' '
