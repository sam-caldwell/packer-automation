.PHONY:=disable-*

disable-parallels:
	@sed -i -e 's/parallels[ ]*:[ ]*enable/parallels:disable/' SUPPORTED_HYPERVISORS.txt

disable-vmware:
	@sed -i -e 's/vmware[ ]*:[ ]*enable/vmware:disable/' SUPPORTED_HYPERVISORS.txt

disable-virtualbox:
	@sed -i -e 's/virtualbox[ ]*:[ ]*enable/virtualbox:disable/' SUPPORTED_HYPERVISORS.txt

disable-hyperv:
	@sed -i -e 's/hyperv[ ]*:[ ]*enable/hyperv:disable/' SUPPORTED_HYPERVISORS.txt

disable-kvm:
	@sed -i -e 's/kvm[ ]*:[ ]*enable/kvm:disable/' SUPPORTED_HYPERVISORS.txt

disable-qemu:
	@sed -i -e 's/qemu[ ]*:[ ]*enable/qemu:disable/' SUPPORTED_HYPERVISORS.txt
