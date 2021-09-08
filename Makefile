include Makefile.d/*.mk

PATH += $HOME/.bin

.DEFAULT_GOAL := help

.PHONY: all
all:
	@echo 'This does not exist.  It would not make any sense.'
