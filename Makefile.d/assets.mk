MANIFEST='$(shell pwd)/assets/manifest.yml'


help-assets:
	$(call print_help_line,"make assets","Fetch all assets identified in the manifest and store them in the cache.")

assets: lint
	python3 $(shell pwd)/scripts/manifest/fetch.py --manifest ${MANIFEST}
