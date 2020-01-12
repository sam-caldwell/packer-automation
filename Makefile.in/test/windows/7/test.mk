
test/windows/7:
	@echo 'test/windows/7'
	@$(MAKE) to/local push/boxes
	@/bin/bash -c "( (cd ./Makefile.in/test/windows/7; vagrant up ) )"
