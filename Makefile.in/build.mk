build:
	echo 'building ${PACKER_FILE}'
	packer build -force -color=true -only=${BUILD_ON_PLATFORM:,=} -var headless=false $(PACKER_FILE)
	echo 'build complete'
