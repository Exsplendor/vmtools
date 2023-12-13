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

make autoinstall: reinstalls every script on any change (for developers)
make devmode: prepends src/ directory to $PATH, to allow immediate testing

endef


## Targets:

.PHONY: install uninstall help

help: export _HELP_TXT:=$(HELP)
help:
	@echo "$${_HELP_TXT}"

install:
	[[ -d ${xprefix} ]] || mkdir ${xprefix}
	@cd src/
	install -C -m744 -t ${xprefix} ${ScriptsToInstall}

uninstall:
	rm ${installed_executables}


## Secondary Targets
AUTOINST := meta/script/autoinstall
autoinstall:
	[[ -x ${AUTOINST} ]] && ${AUTOINST}&


NUMITEMS=${#OLDPATH[*]}
devmode:
	@echo "${NUMITEMS}, ${PATH}"
	
# vi: set noet sw=4 ts=4 list ai cc=78 list:
