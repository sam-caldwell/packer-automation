#
# Packer Build Automation
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
	@echo ' '

clean:
	[ -d ./packer_cache ] && rm -rf ./packer_cache
	rm -rf ./box/*.box

list:
	find ./packer/ -name "*.json" -type f | sed -e 's/\.\/packer\/\//- /' | sed -e 's/\.json//' | sort

hash:
	rm ./iso/hashes.txt
	find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;

win10:
	packer build \
		-force \
		-color=true \
		-var headless=false \
    	packer/windows/windows_10.json


PHONY=win10 clean hash
