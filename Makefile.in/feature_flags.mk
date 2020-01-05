#
# This is the current set of enabled feature flags.
#

on/virtualbox:
	@echo 'enabling build-on virtualbox feature flag'
	export BUILD_ON_PARALLELS=1

on/vmware:
	@echo 'enabling build-on vmware feature flag'
	export BUILD_ON_PARALLELS=1
	@echo 'not implemented in the backend.'
	exit 1

on/aws:
	@echo 'enabling build-on aws feature flag (build AMI)'
	# ToDo: set AWS creds with the feature flag.
	export BUILD_ON_PARALLELS=1
	@echo 'not implemented in the backend.'
	exit 1

on/azure:
	@echo 'enabling build-on vmware feature flag'
	#ToDo: Set the azure creds with the feature flag.
	export BUILD_ON_PARALLELS=1
	@echo 'not implemented in the backend.'
	exit 1

on/parallels:
	@echo 'enabling build-on parallels feature flag'
	export BUILD_ON_PARALLELS=1
	@echo 'not implemented in the backend.'
	exit 1

to/local:
	@echo 'enabling push to/local feature flag'
	export PUSH_TO_LOCAL=1
	@echo 'not implemented in the backend.'
	exit 1

to/vagrantup:
	@echo 'enabling push to/vagrantup feature flag'
	export PUSH_TO_LOCAL=1
	@echo 'not implemented in the backend.'
	exit 1
