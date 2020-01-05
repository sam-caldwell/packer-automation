#
#
#

vagrant-add-box:
	@echo "vagrant-add-box: Adding box (${box}) to vagrant boxes (local)."
	vagrant box add ${box} --name 'asymmetric-effort/$(shell echo ${box} | sed -e 's/\.box//' | sed -e 's/\.\/box\///')'

add-local:
	@find ./box -name "*.box" -type f -exec $(MAKE) box={} vagrant-add-box \;
	@echo "done.  Happy hacking!"
