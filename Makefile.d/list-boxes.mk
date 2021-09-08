.PHONY:=list-boxes, help-list-boxes

help-list-boxes:
	$(call print_help_line,"make list-boxes","List the available boxes you can build.")

list-boxes:
	@find ./box/ -name "*.box" -type f | sed -e 's/\.\/box\/\//- /' | sed -e 's/\.box//' | sort
