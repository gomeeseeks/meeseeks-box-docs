

.PHONY: all
all:
	hugo --disableKinds=RSS --disableKinds=sitemap

.PHONY: setup
setup: 
	git submodule init
	git submodule update
