# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

# sorted by build dependencies
SUBDIRS := debian\:bullseye \
	debian-builder\:bullseye \
	debian-dev-hpc\:bullseye \
	debian-dev-hbrs\:bullseye \
	debian-dev-java\:bullseye \
	debian-dev-python\:bullseye \
	debian-embedded\:bullseye \
	debian-systemd\:bullseye \
	debian-tex\:bullseye

$(TOPTARGETS):
	@for SUBDIR in $(SUBDIRS); do \
		$(MAKE) -C $$SUBDIR $@ || break; \
	done

$(SUBDIRS):
	$(MAKE) -C $@

.NOTPARALLEL: # respect dependencies between docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
