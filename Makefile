VENV ?= .venv

run: venv
	echo "Running the app"

clean-venv:
	rm -rf $(VENV)

re-venv: clean-venv venv


update-requirements:
	uv pip compile requirements.in > requirements.txt


venv:
	@if [ ! -d "$(VENV)" ] || [ requirements.in -nt requirements.txt ] || [ requirements.dev -nt requirements.txt ]; then \
		echo "Creating virtual environment..."; \
		uv venv $(VENV); \
		$(MAKE) venv-install; \
	else \
		echo "Virtual environment is up to date."; \
	fi

venv-install:
	uv pip install -r requirements.txt -r requirements.dev

venv-sync: update-requirements
	uv pip sync requirements.txt
	uv pip sync requirements.dev

upgrade-pydantic: ## Upgrade pydantic and pydantic-settings according to sql meshes docs https://sqlmesh.readthedocs.io/en/stable/installation/#install-extras
	$(VENV)/bin/pip install --upgrade pydantic
	$(VENV)/bin/pip install --upgrade pydantic-settings

