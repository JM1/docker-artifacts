# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

ANSIBLE_MK_PHONY = ansible-install-requirements ansible-cleanup-requirements

.cache/ansible/roles:
	ansible-galaxy install --role-file requirements.yml

ansible-install-requirements: | .cache/ansible/roles

ansible-cleanup-requirements:
	$(RM) -r .cache/ansible/roles
