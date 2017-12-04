# Author: Adrien Lecharpentier <me@alecharp.fr>
.PHONY: build new run release

DOCKER_IMAGE := alecharp/blog
PORT := 1337

build:
	@docker build --rm --force-rm -t ${DOCKER_IMAGE} .

new: build
	@docker run --rm -ti \
		-v $(CURDIR):/usr/src/blog \
		${DOCKER_IMAGE} hugo new $(NAME)

run: build codestyle
	@docker run --rm -ti \
	  -v $(CURDIR):/usr/src/blog \
		-p $(PORT):$(PORT) \
		${DOCKER_IMAGE} hugo server -D --disableFastRender --port=$(PORT) --bind=0.0.0.0

codestyle: build
	@docker run --rm -ti \
		-v $(CURDIR):/usr/src/blog \
		${DOCKER_IMAGE} hugo gen chromastyles --style=colorful > static/css/syntax.css

release: build codestyle
	@docker run --rm -ti \
		-v $(CURDIR):/usr/src/blog \
		${DOCKER_IMAGE} hugo
	@git --git-dir=public/.git --work-tree=public add --all
	@git --git-dir=public/.git --work-tree=public commit -S -m "Publishing to gh-pages"
	@git --git-dir=public/.git --work-tree=public push origin gh-pages
