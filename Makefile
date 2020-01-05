#
# Packer Build Automation
#
#
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

clean:
	[ -d ./packer_cache ] && rm -rf ./packer_cache
	rm -rf ./box/*.box

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
#       This will save time when working local or offline.

#
# Wish list.  Dos.  I really with we had a dos vagrant box for nostalgia.  I miss writing TSRs among other things.
#
# ToDo: add a dos vagrant box.

#
# Windows section.  All the windows boxes should go in this section, ordered alphabetically because this
#                   list is going to get very long.
#
.PHONY: windows/7
windows/7:
	packer build -force -color=true -var headless=false packer/windows/7.json

.PHONY: windows/10
windows/10:
	packer build -force -color=true -var headless=false packer/windows/10.json

.PHONY: windows/81
windows/81:
	packer build -force -color=true -var headless=false packer/windows/81.json

.PHONY: windows/2008_r2
windows/2008_r2:
	packer build -force -color=true -var headless=false packer/windows/2008_r2.json

.PHONY: windows/2008_r2_core
windows/2008_r2_core:
	packer build -force -color=true -var headless=false packer/windows/2008_r2_core.json

.PHONY: windows/2012
windows/2012:
	packer build -force -color=true -var headless=false packer/windows/2012.json

.PHONY: windows/2012_r2
windows/2012_r2:
	packer build -force -color=true -var headless=false packer/windows/2012_r2.json

.PHONY: windows/2012_r2_core
windows/2012_r2_core:
	packer build -force -color=true -var headless=false packer/windows/2012_r2_core.json

.PHONY: windows/2012_r2_hyperv
windows/2012_r2_hyperv:
	packer build -force -color=true -var headless=false packer/windows/2012_r2_hyperv.json

.PHONY: windows/2016
windows/2016:
	packer build -force -color=true -var headless=false packer/windows/2016.json

### End of Windows Section
#
# MacOs / OSX section.  All Apple stuff (macos, osx) should go here ordered alphabetically.
#
#
# ToDo: Add Macos High Sierra
# ToDo: Add MacOs Mojave
# ToDo: Add MacOs Catalina

### End of MacOs Section
#
# Linux section.  All Linux stuff should go here ordered alphabetically.  The list that could go here is long.
#                 names should be linux/<family>/<version>.  For example: linux/ubuntu/18.04_server
#
# ToDo: Add ubuntu 18.04 server.