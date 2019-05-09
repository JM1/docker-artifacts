# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

SUBDIRS := debian debian-dev-hpc debian-systemd debian-dev-full debian-dev-hbrs debian-gltest debian-distcc jupyter-prolog-notebook

$(TOPTARGETS): $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.NOTPARALLEL: # respect dependencies among docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
