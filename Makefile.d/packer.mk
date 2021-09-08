build:
	echo 'building ${PACKER_FILE}'
	packer build -force -color=true -var headless=false $(PACKER_FILE)
	echo 'build complete'
