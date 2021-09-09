MANIFEST='$(shell pwd)/assets/manifest.yml'


fetch-help:
	$(call print_help_line,"make fetch","Fetch all assets identified in the manifest.")

fetch: lint
	python3 $(shell pwd)/scripts/packer/fetch-manifest.py --manifest ${MANIFEST}
