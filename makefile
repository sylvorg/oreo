.RECIPEPREFIX := |
.DEFAULT_GOAL := test

# Adapted From: https://www.systutorials.com/how-to-get-the-full-path-and-directory-of-a-makefile-itself/
mkfilePath := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfileDir := $(dir $(mkfilePath))

tangle:
|make -f $(mkfileDir)/settings/makefile tangle-setup
|$(mkfileDir)/settings/org-tangle.sh $(mkfileDir)/oreo/*.org
|$(mkfileDir)/settings/org-tangle.sh $(mkfileDir)/tests.org
|$(mkfileDir)/settings/org-tangle.sh $(mkfileDir)/shell.org

install: tangle
|pip install .

repl:
|hy

replit: tangle install repl

test: tangle
|hy $(mkfileDir)/tests.hy