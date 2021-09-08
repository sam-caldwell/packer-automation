MANIFEST='$(shell pwd)/assets/manifest.yml'

fetch-help:
	$(call print_help_line,"make fetch/all","Fetch all assets (fetch-*).")
	$(call print_help_line,"make fetch/iso","Fetch all assets (fetch-*).")
	$(call print_help_line,"make fetch/windows","Fetch the windows files listed in assets/manifest.yml.")
	$(call print_help_line,"make fetch/linux/deb","Fetch the linux/deb files listed in assets/manifest.yml.")
	$(call print_help_line,"make fetch/linux/rpm","Fetch the linux/rpm files listed in assets/manifest.yml.")
	$(call print_help_line,"make fetch/linux/src","Fetch the linux/src files listed in assets/manifest.yml.")
	$(call print_help_line,"make fetch/macos","Fetch the macos files listed in assets/manifest.yml.")

define fetcher
	@echo "fetch iso images in ${1}"
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py ${2} --type ${3} --manifest ${1}

endef

fetch/all: fetch/iso \
		   fetch/windows \
		   fetch/linux/deb \
		   fetch/linux/rpm \
		   fetch/linux/src \
		   fetch/macos

fetch/iso:
	@echo 'fetch iso images in $(MANIFEST)'
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"iso")

fetch/windows:
	@echo 'fetch windows assets from $(MANIFEST)'
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"windows")

fetch/linux/deb:
	MANIFEST=assets/linux/deb/manifest.yaml
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"linux/deb")

fetch/linux/rpm:
	MANIFEST=assets/linux/rpm/manifest.yaml
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"linux/rpm")

fetch/linux/src:
	MANIFEST=assets/linux/src/manifest.yaml
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"linux/src")

fetch/macos:
	MANIFEST=assets/macos/manifest.yaml
	$(call fetcher,$(MANIFEST),$(USE_FORCE),"macos")
