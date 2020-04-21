# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

.cache/ansible/roles:
	ansible-galaxy role install --role-file requirements.yml

.cache/ansible/collections:
	ansible-galaxy collection install --requirements-file requirements.yml

ansible-install-requirements: | .cache/ansible/roles .cache/ansible/collections
.PHONY: ansible-install-requirements

ansible-cleanup-requirements:
	$(RM) -r .cache/ansible/roles
	$(RM) -r .cache/ansible/collections
.PHONY: ansible-cleanup-requirements
