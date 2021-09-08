.PHONY: list-hypervisors

list-hypervisors:
	@echo ""
	@echo "-----------------------------------------------------------"
	@echo "The following hypervisors are supported:"
	@echo "-----------------------------------------------------------"
	@while read -r line; do \
	  echo "$$line" | awk '{printf "%25s %s\n", $$1, $$2}'; \
	done < "SUPPORTED_HYPERVISORS.txt"
	@echo "-----------------------------------------------------------"
