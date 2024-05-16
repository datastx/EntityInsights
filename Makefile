
run: venv
	$(VENV)/python applications/app.py


include Makefile.venv
Makefile.venv:
	curl \
		-o Makefile.fetched \
		-L "https://github.com/sio/Makefile.venv/raw/v2023.04.17/Makefile.venv"
	echo "fb48375ed1fd19e41e0cdcf51a4a0c6d1010dfe03b672ffc4c26a91878544f82 *Makefile.fetched" \
		| sha256sum --check - \
		&& mv Makefile.fetched Makefile.venv


upgrade-pydantic: ## Upgrade pydantic and pydantic-settings according to sql meshes docs https://sqlmesh.readthedocs.io/en/stable/installation/#install-extras
	$(VENV)/pip install --upgrade pydantic
	$(VENV)/pip install --upgrade pydantic-settings

