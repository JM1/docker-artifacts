# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

DOCKER_REPOSITORY = jm1337/jupyter-prolog-notebook
DOCKER_TAG = testing

include ../.config/docker.mk

.DEFAULT_GOAL := all

.PHONY: all $(DOCKER_MK_PHONY)

.NOTPARALLEL: # respect dependencies among targets

all: docker-build

clean: ;
