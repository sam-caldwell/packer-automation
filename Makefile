#
# Packer Build Automation
#
#
-include Makefile.in/setup.mk
-include Makefile.in/packer.mk
-include Makefile.in/windows/Makefile
-include Makefile.in/macos/Makefile
-include Makefile.in/linux/Makefile

.DEFAULT_GOAL := help

help:
	@echo 'Packer build automation Makefile'
	@echo ' '
	@echo 'Usage'
	@echo ' '
	@echo 'make clean     : ...to clean up old boxes, run...'
	@echo 'make setup     : ...to setup your local environment (from scratch).'
	@echo 'make list      : ...to list the available boxes you can build.'
	@echo 'make list-boxes: ...to list the boxes we have built.'
	@echo 'make <opsys>   : ...to create a box with the given operating system config.'
	@echo 'make build     : ...to make a build the hard way (specify the packer file).'
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

add-local:
	@echo "Adding box (${box}) from ./box/${box}.box to vagrant boxes (local)."
	@[ ! -f "box/${box}.box" ] && echo "box not found: '${box}'" && exit 1
	@VERSION=$(date +%s)
	@BOX_NAME="packer-automation/$(box)"
	@vagrant box add box/${box} --box-version $(VERSION) --name $(BOX_NAME)
	@echo "Added box ($(box)) as ($BOX_NAME:$VERSION)"
	@@echo "done.  Happy hacking!"

.PHONY: all
all:
	@echo 'Executing everything...this is gonna take a long time.'

# ToDo: Add a `make inventory` to create an `inventory.txt` of working environments.
# ToDo: Add `make fetch` to download all artifacts that we would need for this repo.  Binaries, isos, etc.
