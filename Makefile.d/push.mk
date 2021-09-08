push:
	@echo 'push-to local:${PUSH_TO_LOCAL} vagrantup:${PUSH_TO_VAGRANTUP}'
	@if [ "$(PUSH_TO_LOCAL)" = "1" ]; then $(MAKE) push-to-local; fi
	@if [ "$(PUSH_TO_VAGRANTUP)" = "1" ]; then $(MAKE) push-to-vagrantup; fi
	@echo "done.  Happy hacking!"


push-to-local:
	@find ./box -name "*.box" -type f -exec $(MAKE) box={} vagrant-add-box \;


vagrant-add-box:
	@echo "vagrant-add-box: Adding box (${box}) to vagrant boxes (local) '$(USE_FORCE)'"
	vagrant box add ${box} $(USE_FORCE) --name 'asymmetric-effort/$(shell echo ${box} | \
		sed -e 's/\.box//' | \
		sed -e 's/\.\/box\///')'


push-to-vagrantup:
	@echo 'remote push is not implemented yet.  please consider contributing this feature.'
	exit 1
