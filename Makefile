# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

# sorted by build dependencies
SUBDIRS := debian\:buster debian\:bullseye \
	debian-dev-hpc\:buster debian-dev-hpc\:bullseye \
	debian-dev-full\:buster debian-dev-full\:bullseye \
	debian-dev-hbrs\:buster debian-dev-hbrs\:bullseye \
	debian-systemd\:buster debian-systemd\:bullseye \
	debian-gltest\:buster \
	debian-distcc\:buster \
	jupyter-prolog-notebook \
	debian-tex\:buster

$(TOPTARGETS): $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

.NOTPARALLEL: # respect dependencies between docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
