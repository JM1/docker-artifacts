# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

DOCKER_REPOSITORY = jm1337/bash-lsp-server
DOCKER_TAG = rawhide

include ../.config/docker.mk

.DEFAULT_GOAL := all

.NOTPARALLEL: # respect dependencies among targets

all: docker-build
.PHONY: all

clean: ;
.PHONY: clean
