
list:
	@find ./packer/ -name "*.json" -type f | sed -e 's/\.\/packer\/\//- /' | sed -e 's/\.json//' | sort
