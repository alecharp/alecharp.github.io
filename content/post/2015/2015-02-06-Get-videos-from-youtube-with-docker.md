---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2015-02-06T00:00:00Z
tags: docker en youtube-dl
title: Get videos from Youtube with Docker
url: /2015/02/06/Get-videos-from-youtube-with-docker/
---

Last week I created my first docker image to be able to get videos from youtube without having to install anything on my computer.

## Youtube-dl

For a year or two, I used [`youtube-dl`][youtube-dl] to download any videos from the video platform in order to have a offline version of any videos I'd like to watch. This is very useful to watch them in public transport or when you have a bad internet connection.

As I recently change of macbook, I tried to install as few software as possible. The idea was to remove any `npm`/`bower` crap. I even extend this to `youtube-dl`. Why? To reduce the possible issues with `brew upgrade` or any conflicts with other package manager.

## Docker-ization

There are some `youtube-dl` based images that can be found on the [docker-registry](https://registry.hub.docker.com/search?q=youtube-dl). But I wanted to create and offer something more. Not that I don't trust unofficial images, but I wanted to base this one on an official one. So let's go for a `debian:sid`.

I could have just install the `youtube-dl` binary and set the `ENTRYPOINT` on it. But, as I said, I wanted to offer something more. So I joined the `dl.sh` script which will be executed to download the videos. Having such a entrypoint will also enable to add new _features_ on-top of `youtube-dl`.

That is what I've done on the version `1.1`. The first version (1.0) was only able to download the video and audio from the link. On version `1.1`, there is a `--audio` parameter to specify that you only want the audio of the following link.

Adding new _features_ will be done only on the `dl.sh` script without changing the `Dockerfile`. So the only modifications that will be done on the `Dockerfile` would be the upgrade of `curl`, `python` or `ffmpeg`.

I can even change the entrypoint from `dl.sh` to any other script written in any other language, the end users shouldn't notice.

## From unstable to stable and reproductible

I spoke about this image with my friend Olivier Croissier and he said:

> Your image is not really reproductible

And he's right. Again.

See on my `Dockerfile`, I run `apt-get update && apt-get upgrade`. So from one build to another, I can have a core package version that have change and introduce a bug. It is the same problem when I install `curl`, `python2.7` and `ffmpeg`. Even worst I get the `lastest` from `youtube-dl`.

So to make my image stable and reproductible, I have to set the version of each package I want to install. So that I'm sure that from one build to another, without changing the `Dockerfile`, the package used will be the same.

But if you are "just" using the image, you can use the tags (`1.0`, `1.1`, etc.) and those images are fix and won't move.

## Usage

So you can find the script and `Dockerfile` on Github: [alecharp/get-videos][github]. And the docker image on the registry: [alecharp/get-video][docker].

To use the my image:

```bash
docker pull alecharp/get-videos:1.1
docker run --rm -v "$(pwd)":/downloads alecharp/get-videos [--audio] URL [ [--audio] URL]
```

All the files are downloaded into the volume `/downloads` of the container. When docker 1.5 will be released, the flag `--read-only` will be usefull to be sure to store the files on your host, not on the container.

The files are stored into a folder named after the uploader name.

On my git repository, I'm using something like the `git-flow` process so:

 - `master` is stable
 - `dev` is latest and unstable

and I create a tag (`git` and docker) for every release. I add the changelog in the `README.md` file that you can see on both Github and Docker registry.

## Conclusion

This is my first Docker image. It is not the most useful image of all time as some others already offer to use `youtube-dl`. But I hope you will like it.

## Links

 - [`youtube-dl`][youtube-dl]
 - [Github repository][github]
 - [Docker image][docker]
 - Olivier Croisier:
    - [@OlivierCroisier](https://twitter.com/OlivierCroisier)
    - [TheCodersBreakfast.net](http://thecodersbreakfast.net)

[youtube-dl]: http://rg3.github.io/youtube-dl/
[github]: https://github.com/alecharp/get-videos
[docker]: https://registry.hub.docker.com/u/alecharp/get-videos/
