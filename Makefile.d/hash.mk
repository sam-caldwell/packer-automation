.PHONY:=hash

hash:
	@mkdir -p ./iso &> /dev/null || true
	@rm ./iso/hashes.txt &> /dev/null || true
	@find ./iso/ -name "*.iso" -type f -exec shasum -a 1 {}  >> ./iso/hashes.txt \;
