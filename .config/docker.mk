# vim:set syntax=make:
# kate: syntax Makefile; tab-indents on; replace-tabs off;

docker-build:
	repository="$(DOCKER_REPOSITORY)";                             \
	[ -z "$$repository" ] && exit 1;                               \
	                                                               \
	tag="$(DOCKER_TAG)";                                           \
	[ -z "$$tag" ] && tag="latest";                                \
	                                                               \
	pull="$(DOCKER_PULL)";                                         \
	[ -z "$$pull" ] && pull=false;                                 \
	                                                               \
	no_cache="$(DOCKER_CACHE)";                                    \
	[ -z "$$no_cache" ] && no_cache=false;                         \
	                                                               \
	docker build                                                   \
	    --pull=$$pull                                              \
	    --no-cache=$$no_cache                                      \
	    -t "$$repository:$$tag-$$(date +%Y%m%d)"                   \
	    -t "$$repository:$$tag"                                    \
	    .;
.PHONY: docker-build

docker-pull:
	repository="$(DOCKER_REPOSITORY)";                             \
	[ -z "$$repository" ] && exit 1;                               \
	                                                               \
	tag="$(DOCKER_TAG)";                                           \
	[ -z "$$tag" ] && tag="latest";                                \
	                                                               \
	docker pull "$$repository:$$tag"
.PHONY: docker-pull

docker-push:
	repository="$(DOCKER_REPOSITORY)";                             \
	[ -z "$$repository" ] && exit 1;                               \
	                                                               \
	tag="$(DOCKER_TAG)";                                           \
	[ -z "$$tag" ] && tag="latest";                                \
	                                                               \
	docker push "$$repository:$$tag"
.PHONY: docker-push
