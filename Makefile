win10:
	packer build \
		-force \
		-color=true \
		-var headless=false \
    	-var iso_url=./iso/win10.iso \
    	-var unattend=./answer_files/10/Autounattend.xml \
    	-var iso_checksum=489ebee676e26cdb81377b0e6385c001a22589b8 windows_10.json


PHONY=win10