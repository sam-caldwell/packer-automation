#
# This is the current set of enabled feature flags.
#
-include ff-on-aws.mk
-include ff-on-azure.mk
-include ff-on-parallels.mk
-include ff-on-vmware.mk
-include ff-to-vagrantup.mk

on/virtualbox:
	@echo 'enabling build-on virtualbox feature flag'
	export ON_VIRTUALBOX=1

on/vmware:
	@echo 'enabling build-on vmware feature flag'
	export ON_VMWARE=1
	@echo 'not implemented in the backend.'
	exit 1

on/aws:
	@echo 'enabling build-on aws feature flag (build AMI)'
	# ToDo: set AWS creds with the feature flag.
	export ON_AWS=1
	@echo 'not implemented in the backend.'
	exit 1

on/azure:
	@echo 'enabling build-on vmware feature flag'
	#ToDo: Set the azure creds with the feature flag.
	export ON_AZURE=1
	@echo 'not implemented in the backend.'
	exit 1

on/parallels:
	@echo 'enabling build-on parallels feature flag'
	export ON_PARALLELS=1
	@echo 'not implemented in the backend.'
	exit 1

to/vagrantup:
	@echo 'enabling push-to vagrantup feature flag'
	export TO_VAGRANTUP=1
	@echo 'not implemented in the backend.'
	exit 1
