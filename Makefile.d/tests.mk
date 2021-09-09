include Makefile.d/tests/*.mk
.PHONY:=test

test: lint test-python
	@echo "tests complete"
