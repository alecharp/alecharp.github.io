---
layout: default
title: Adrien Lecharpentier's blog
---

<ul class="posts">
{% for post in site.posts %}
  <li>
    <a href="{{post.url}}">{{post.title}}</a>
    <span class="pull-right muted">{{post.date | date_to_string}}</span>
  </li>
{% endfor %}
</ul>