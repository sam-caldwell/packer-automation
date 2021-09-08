.PHONY:=enable-*

enable-parallels:
	@sed -i -e 's/parallels[ ]*:[ ]*disable/parallels:enable/' SUPPORTED_HYPERVISORS.txt

enable-vmware:
	@sed -i -e 's/vmware[ ]*:[ ]*disable/vmware:enable/' SUPPORTED_HYPERVISORS.txt

enable-virtualbox:
	@sed -i -e 's/virtualbox[ ]*:[ ]*disable/virtualbox:enable/' SUPPORTED_HYPERVISORS.txt

enable-hyperv:
	@sed -i -e 's/hyperv[ ]*:[ ]*disable/hyperv:enable/' SUPPORTED_HYPERVISORS.txt

enable-kvm:
	@sed -i -e 's/kvm[ ]*:[ ]*disable/kvm:enable/' SUPPORTED_HYPERVISORS.txt

enable-qemu:
	@sed -i -e 's/qemu[ ]*:[ ]*disable/qemu:enable/' SUPPORTED_HYPERVISORS.txt
