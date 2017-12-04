---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2015-01-22T00:00:00Z
tags: docker en
title: Docker - Mr Proper speaking
url: /2015/01/22/Docker-mr-proper-speaking/
---

Since a couple of weeks, I'm using docker for development purpose but also to fix some code issues. I'm also using it for this blog..

But even if I have a quite large _hard drive_ (512GB), from time to time I like to remove all the containers and from time to time, also the images. So:

```bash
docker rm $(docker ps -aq) && docker rmi $(docker images -q)
```

It's remind me the `make mrproper` I had in my old `Makefile` to remove all generated files from my C projects.

> It's not really clean if you haven't used Mr Proper to clean it..

As I'm quite a Git-fanboy, I'd like to be able to create my only aliases for docker. So I'd be able to use `docker mrproper` to call the previous command. But until then, it will be on my `zsh` aliases.
