# Author: Adrien Lecharpentier <adrien.lecharpentier@gmail.com>

src_dir := $(shell pwd)
dest_dir ?= /tmp/site

serve:
	docker run --rm -v $(src_dir):/src -p 4000:4000 grahamc/jekyll server -H 0.0.0.0 --future --draft

build:
	docker run --rm -v $(src_dir):/src grahamc/jekyll build -t --destination $(dest_dir)

version:
	docker run --rm grahamc/jekyll --version
