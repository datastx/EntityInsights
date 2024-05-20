# Set shell to bash to use more advanced features
SHELL := /bin/bash
# Set error flags
.SHELLFLAGS = -o errexit -o nounset -o pipefail -c
# Make sure the first target executed is 'all' if no target is specified
.DEFAULT_GOAL := all

VENV ?= .venv

all: run

run: venv
	@echo "Running the app"

clean-venv:
	@rm -rf $(VENV)

re-venv: clean-venv venv

update-requirements:
	@echo "Updating requirements..."
	@uv pip compile --python-platform=linux --python-version=3.10 requirements.in > requirements.txt

venv:
	@if [ ! -d "$(VENV)" ] || [ requirements.in -nt requirements.txt ] || [ requirements.dev -nt requirements.txt ]; then \
		echo "Creating virtual environment..."; \
		uv venv $(VENV); \
		$(MAKE) update-requirements; \
		$(MAKE) venv-install; \
	else \
		echo "Virtual environment is up to date."; \
	fi

venv-install:
	@uv pip install -r requirements.txt -r requirements.dev

venv-sync: update-requirements
	@uv pip sync requirements.txt
	@uv pip sync requirements.dev
