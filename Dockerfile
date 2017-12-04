FROM alpine:3.6
MAINTAINER Adrien Lecharpentier <me@alecharp.fr>

RUN apk --update --no-cache add \
  curl \
  tar

RUN adduser -h /usr/src/blog -D -u 1000 blog blog

ENV HUGO_VERSION 0.31.1
RUN curl -sSL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -v -C /usr/local/bin -xz

USER blog
WORKDIR /usr/src/blog
