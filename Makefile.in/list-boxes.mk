
list-boxes:
	@find ./box/ -name "*.box" -type f | sed -e 's/\.\/box\/\//- /' | sed -e 's/\.box//' | sort