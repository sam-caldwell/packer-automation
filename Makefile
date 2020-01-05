#
# Packer Build Automation
#
#
-include Makefile.in/windows/Makefile
-include Makefile.in/macos/Makefile
-include Makefile.in/linux/Makefile

help:
	@echo 'Packer build automation Makefile'
	@echo ' '
	@echo 'Usage'
	@echo ' '
	@echo 'make clean    : ...to clean up old boxes, run...'
	@echo 'make setup    : ...to setup your local environment (from scratch).'
	@echo 'make list     : ...to list the available boxes you can build.'
	@echo 'make <opsys>  : ...to create a box with the given operating system config.'
	@echo 'make all      : ...to make clean and run against all your boxes. (and probably heat your home).'
	@echo ' '
	@echo 'documentation: https://github.com/sam-caldwell/packer-automation'

clean:
	@echo "Cleaning..."
	[ -d ./packer_cache ] && rm -rf ./packer_cache
	rm -rf ./box/*.box  &> /dev/null
	rm -rf ./output-virtualbox* &> /dev/null
	rm -rf ./output-vmware &> /dev/null
	rm -rf ./output-parallels &> /dev/null
	rm -rf ./packer_cache &> /dev/null

list:
	find ./packer/ -name "*.json" -type f | sed -e 's/\.\/packer\/\//- /' | sed -e 's/\.json//' | sort

hash:
	rm ./iso/hashes.txt
	find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;

.PHONY: all
all:
	@echo 'Executing everything...this is gonna take a long time.'

# ToDo: Add a `make inventory` to create an `inventory.txt` of working environments.
# ToDo: Add `make fetch` to download all artifacts that we would need for this repo.  Binaries, isos, etc.
