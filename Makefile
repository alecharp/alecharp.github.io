# Author: Adrien Lecharpentier <me@alecharp.fr>
.PHONY: build new run release less

DOCKER_IMAGE := alecharp/blog
PORT := 1337

build:
	@docker build --rm --force-rm -t ${DOCKER_IMAGE} .

run: build codestyle
	@docker run --rm -ti \
	  -v $(CURDIR):/usr/src/blog \
		-p $(PORT):$(PORT) \
		${DOCKER_IMAGE} hugo server -FD --disableFastRender --port=$(PORT) --bind=0.0.0.0

codestyle: build
	@docker run --rm -ti \
		-v $(CURDIR):/usr/src/blog \
		${DOCKER_IMAGE} hugo gen chromastyles --style=colorful > static/css/syntax.css

less:
	@docker run --rm -ti \
	  -v $(CURDIR):/usr/src/blog \
		-w /usr/src/blog \
		node:9-alpine \
			sh -c "npm install -g less less-plugin-clean-css && \
			lessc --clean-css less/index.less static/css/index.css"

release: build less codestyle
	@docker run --rm -ti -v $(CURDIR):/usr/src/blog ${DOCKER_IMAGE} hugo
	@git --git-dir=public/.git --work-tree=public add --all
	@git --git-dir=public/.git --work-tree=public commit -S -m "Publishing to gh-pages"
	@git --git-dir=public/.git --work-tree=public push origin gh-pages
