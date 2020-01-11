
hash:
	@rm ./iso/hashes.txt
	@find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;