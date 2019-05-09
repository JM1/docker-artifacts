# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

PACKER_MK_PHONY = packer

packer:
	packer build -var-file=variables.json template.json

