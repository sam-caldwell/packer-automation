lint:
	@echo 'linting the code repo.'
	@$(MAKE) yamllint

yamllint:
	@for file in $(shell find ./ -name "*.yml" -type f); do \
		echo "  linting file: $$file"; \
		yamllint -c ./yamllint.yml $$file || exit 1; \
	done
