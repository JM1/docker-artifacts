# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

# sorted by build dependencies
SUBDIRS := debian:buster \
	debian-dev-hpc:buster \
	debian-dev-full:buster \
	debian-dev-hbrs:buster \
	debian-systemd:buster \
	debian-gltest:buster \
	debian-distcc:buster \
	jupyter-prolog-notebook \
	debian-tex:buster

$(TOPTARGETS): $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.NOTPARALLEL: # respect dependencies between docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
