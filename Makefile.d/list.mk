.PHONY:=list, help-list

help-list:
	$(call print_help_line,"make list","list the images built by the project.")


list:
	@find ./packer/ -name "*.json" -type f | sed -e 's/\.\/packer\/\//- /' | sed -e 's/\.json//' | sort
