# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

DOCKER_REPOSITORY = jm1337/debian
DOCKER_TAG = testing

include ../.config/ansible.mk
include ../.config/packer.mk
include ../.config/docker.mk

.DEFAULT_GOAL := all

.PHONY: all $(ANSIBLE_MK_PHONY) $(PACKER_MK_PHONY) $(DOCKER_MK_PHONY)

.NOTPARALLEL: # respect dependencies among targets

all: ansible-install-requirements packer

clean-cache:
	$(RM) -r .cache/

clean: ansible-cleanup-requirements clean-cache
