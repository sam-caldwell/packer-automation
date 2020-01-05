MANIFEST='$(shell pwd)/assets/manifest.yml'
fetch/iso:
	@echo 'fetch iso images in $(MANIFEST)'
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type iso --manifest $(MANIFEST)

fetch/windows:
	@echo 'fetch windows assets from $(MANIFEST)'
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type windows --manifest $(MANIFEST)

fetch/linux/deb:
	MANIFEST=assets/linux/deb/manifest.yaml
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type linux/deb --manifest $(MANIFEST)

fetch/linux/rpm:
	MANIFEST=assets/linux/rpm/manifest.yaml
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type linux/rpm --manifest $(MANIFEST)

fetch/linux/src:
	MANIFEST=assets/linux/src/manifest.yaml
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type linux/src --manifest $(MANIFEST)

fetch/macos:
	MANIFEST=assets/macos/manifest.yaml
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --type macos --manifest $(MANIFEST)

fetch/all:
	@echo 'fetching all assets.'
	@$(MAKE) fetch/iso
	@$(MAKE) fetch/windows
	@$(MAKE) fetch/linux/deb
	@$(MAKE) fetch/linux/rpm
	@$(MAKE) fetch/linux/src
	@$(MAKE) fetch/mac
