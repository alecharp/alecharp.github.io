---
layout: posts
date: 2015-02-18
author:
  name: Adrien Lecharpentier
  email: adrien.lecharpentier@gmail.com
title: Get videos from Youtube with Docker - part 2
tags: docker youtube-dl en shell
---

In my previous post {% post 2015-02-06-Get-videos-from-youtube-with-docker %}, I've shown how I get fetch videos from Youtube from my command line without installing anything else than Docker. But the command to type is way too complicated

So I made a `shell` script to easily use my docker container.

```shell
#!/bin/sh
## Author: Adrien Lecharpentier <adrien.lecharpentier@gmail.com>

status=$(boot2docker status)
if [ "${status}" != "running" ]; then
  boot2docker start
fi
docker run -ti -v "$(pwd)":/downloads alecharp/get-videos:latest $@
```

This way, I can easily download any youtube (or other) videos without having to remember every argument to give to the docker command. I only have to say:

```shell
sh get-videos.sh $URL
```

and it downloads the video in the current folder.

You can find the script here : https://gist.github.com/alecharp/768cd7bf7f7c4d87609f

Thanks for reading.
