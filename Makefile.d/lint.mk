define linter_func
	@$(foreach file, $(shell find . -type f -name ${1} | grep -v .github), echo "Linting $(file)";${2} $(file))

endef

help-lint:
	$(call print_help_line,"make lint","Execute the linters on the project repository.")

lint: yaml-lint json-lint bash-lint python-lint
	@echo 'linter: success.'

yaml-lint:
	$(call linter_func,*.yml,yamllint -c yamllint.yml)
	$(call linter_func,*.yaml,yamllint -c yamllint.yml)

json-lint:
	$(call linter_func,*.json,jsonlint -q)

bash-lint:
	$(call linter_func,*.sh,shellcheck -a)

python-lint:
	echo "Linting Python"
	@flake8
