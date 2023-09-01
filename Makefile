#!/usr/bin/bash
# project: Virtual Machine Tools
# date   : 09/12/21
# author : Splendor
# desc   : ProtOS development helpers


## Makfefile-Defaults

SHELL := bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.ONESHELL:
.DELETE_ON_ERROR:
.RECIPEPREFIX = >


## Project Defaults:

TITLE := Virtual Machine Tools
ScriptsToInstall := checkvm fetchiso mkimg launchvm

prefix = ${HOME}/.local
xprefix = ${prefix}/bin
installed_executables:=$(addprefix ${xprefix}/, ${ScriptsToInstall})

define HELP

make install: installs $(ScriptsToInstall)
make uninstall: removes $(ScriptsToInstall)
make help: shows the text you are currently reading

endef


## Targets:

.PHONY: install uninstall help

help: export _HELP_TXT:=$(HELP)
help:
> @echo "$${_HELP_TXT}"

install:
> test -d ${xprefix} || mkdir ${xprefix}
> @cd src/
> install -C -m744 -t ${xprefix} ${ScriptsToInstall}

uninstall:
> rm ${installed_executables}

# vi: set noet sw=4 ts=4 list ai cc=78:
