-include Makefile.in/test/macos/test.mk
-include Makefile.in/test/linux/test.mk
-include Makefile.in/test/windows/test.mk

test:
	@echo 'running all tests'
	@$(MAKE) test/windows
	@$(MAKE) test/macos
	@$(MAKE) test/linux
	@exit 0

