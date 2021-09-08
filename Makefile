PATH += $HOME/.bin
.DEFAULT_GOAL := help

include Makefile.d/*.mk

#
# Detect our current operating system
# and make sure this information is available
# to our entire Makefile system
#
ifeq ($(OS),Windows_NT)
    export HOST_OS=windows
    export POSIX=no
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        export HOST_OS=linux
        export POSIX=yes
    endif
    ifeq ($(UNAME_S),Darwin)
        export HOST_OS=macos
        export POSIX=yes
    endif
endif
#
# Detect our current architecture
# and make sure this information is available
# to our entire Makefile system
#
ifeq ($(POSIX),yes)
	RAW_ARCH:=$(shell uname -m)
	ifeq ($(RAW_ARCH),x86_64)
		export ARCH=amd64
	else
		export ARCH=not_set
	endif
else
	RAW_ARCH:=$(PROCESSOR_ARCHITECTURE)
	ifeq ($(RAW_ARCH),AMD64)
		export ARCH=amd64
	else
		export ARCH=not_set
	endif
endif

get_env:
	@echo "--------------------------------"
	@echo "RAW_ARCH: ${RAW_ARCH}"
	@echo "ARCH:     ${ARCH}"
	@echo "HOST_OS:  ${HOST_OS}"
	@echo "POSIX:    $(POSIX)"
	@echo "--------------------------------"

.PHONY: all
all:
	@echo 'This does not exist.  It would not make any sense.'
