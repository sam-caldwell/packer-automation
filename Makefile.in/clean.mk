#
# Makefile.in/clean.mk
# (c) 2020 Sam Caldwell.  See LICENSE.txt
#
clean:
	@echo "Cleaning..."
	@rm -rf ./packer_cache &> /dev/null
	@rm -rf ./output-virtualbox* &> /dev/null
	@rm -rf ./output-vmware &> /dev/null
	@rm -rf ./output-parallels &> /dev/null
	@rm -rf ./packer_cache &> /dev/null
	@rm -rf ./box/ &> /dev/null
	@mkdir -p ./box/{windows,macos,linux}