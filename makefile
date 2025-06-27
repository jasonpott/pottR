# Makefile for R package project using renv and devtools

.PHONY: all document test check readme install snapshot push

all: document test readme check snapshot

document:
	Rscript -e "devtools::document()"

test:
	Rscript -e "devtools::test()"

readme:
	Rscript -e "devtools::build_readme()"

check:
	Rscript -e "devtools::check()"

install:
	Rscript -e "devtools::install()"

snapshot:
	Rscript -e "if (file.exists('renv.lock')) renv::snapshot()"

push:
	@echo "Detecting new functions..."
	$(eval FUNCS := $(shell git diff --cached --name-only man/ | grep '\.Rd$$' | sed 's|man/\(.*\)\.Rd|\1()|' | tr '\n' ' '))
	@if [ -z "$(FUNCS)" ]; then \
		MSG="Update package: automatic commit from Makefile"; \
	else \
		MSG="Add functions: $(FUNCS)"; \
	fi; \
	git commit -m "$$MSG"; \
	git push
