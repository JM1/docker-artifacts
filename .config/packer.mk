# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

packer:
	packer build -var-file=variables.json template.json
.PHONY: packer
