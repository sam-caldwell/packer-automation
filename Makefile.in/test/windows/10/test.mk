test/windows/10:
	@echo 'test/windows/10'
	@$(MAKE) to/local push/boxes
	@/bin/bash -c "( (cd ./Makefile.in/test/windows/10; vagrant up ) )"
	@/bin/bash -c "( (cd ./Makefile.in/test/windows/10; vagrant ssh 'choco /?' ) )"
	@/bin/bash -c "( (cd ./Makefile.in/test/windows/10; vagrant ssh 'choco install /y python3' ) )"