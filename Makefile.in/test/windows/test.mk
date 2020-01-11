#
# windows/test.mk
#
-include 7/test.mk
-include 81/test.mk
-include 2008/test.mk
-include 2012/test.mk
-include 2016/test.mk

test/windows/main:
	@echo 'tests for windows are not implemented yet.'
	exit 1

test:
	@echo 'testing $(OS)'
	exit 1