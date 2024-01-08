# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

TOPTARGETS := all clean docker-push docker-pull

# sorted by build dependencies
SUBDIRS := ansible\:bookworm \
	bootstrap-docker\:bookworm \
	debian\:bookworm \
	debian\:bullseye \
	debian-builder\:bookworm \
	debian-builder\:bullseye \
	debian-dev-hpc\:bullseye \
	debian-dev-hbrs\:bullseye \
	debian-dev-java\:bullseye \
	debian-packaging\:bookworm \
	debian-packaging\:bullseye \
	debian-systemd\:bullseye \
	devbox\:rawhide \
	dhcpd\:rawhide \
	embedded\:bookworm \
	httpd\:rawhide \
	python\:rawhide \
	tex\:bullseye \
	tftpd\:rawhide

$(TOPTARGETS):
	@for SUBDIR in $(SUBDIRS); do \
		$(MAKE) -C $$SUBDIR $@ || break; \
	done

$(SUBDIRS):
	$(MAKE) -C $@

.NOTPARALLEL: # respect dependencies between docker images

.PHONY: $(TOPTARGETS) $(SUBDIRS)
