# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

DOCKER_REPOSITORY = jm1337/debian-dev-full
DOCKER_TAG = buster

include ../.config/ansible.mk
include ../.config/packer.mk
include ../.config/docker.mk

.DEFAULT_GOAL := all

.NOTPARALLEL: # respect dependencies among targets

all: ansible-install-requirements packer docker-build
.PHONY: all

clean-cache:
	$(RM) -r .cache/
.PHONY: clean-cache

clean: ansible-cleanup-requirements clean-cache
.PHONY: clean
