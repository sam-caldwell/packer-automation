push/assets:
	@echo 'push assets to AWS S3: create.sh/packer-automation/'
	@find ./assets/ -name ".DS_Store" -type f -delete
	@aws s3 sync --acl public-read ./assets s3://create.sh/packer-automation/