# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

# sorted by build dependencies
SUBDIRS := debian debian-dev-hpc debian-systemd \
	debian-dev-full debian-dev-hbrs debian-gltest debian-distcc jupyter-prolog-notebook debian-tex

$(TOPTARGETS): $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.NOTPARALLEL: # respect dependencies between docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
