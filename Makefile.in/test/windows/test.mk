#
# windows/test.mk
#
-include Makefile.in/test/windows/7/test.mk
-include Makefile.in/test/windows/81/test.mk
-include Makefile.in/test/windows/2008/test.mk
-include Makefile.in/test/windows/2012/test.mk
-include Makefile.in/test/windows/2016/test.mk

test/windows:
	@echo "running all windows tests."
	@$(MAKE) test/windows/7
	@$(MAKE) test/windows/81
	@$(MAKE) test/windows/10
	@$(MAKE) test/windows/2008
	@$(MAKE) test/windows/2012
	@$(MAKE) test/windows/2016
