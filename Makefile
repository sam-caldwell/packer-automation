clean:
	[ -d ./packer_cache ] && rm -rf ./packer_cache
	rm -rf ./box/*.box

hash:
	rm ./iso/hashes.txt
	find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;

win10:
	packer build \
		-force \
		-color=true \
		-var headless=false \
    	packer/windows/windows_10.json


PHONY=win10 clean hash
