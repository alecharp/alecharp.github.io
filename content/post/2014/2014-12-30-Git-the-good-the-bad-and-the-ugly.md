---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2014-12-30T00:00:00Z
tags: git open-source en
title: Git - the good, the bad and the ugly
url: /2014/12/30/Git-the-good-the-bad-and-the-ugly/
---

I'm using Git for everthing. Two years ago, I even moved my blog from Wordpress to Jekyll, only to be able to use Git. I'm  a huge fan of Git. It's lightweight, powerful, customizable. It's awesome. But some rules must be setup.

# The good

Git is very popular for open-source projects. Even many projects from the Apache Foundation moved to Git and Github a few months back. My opinion is that the lightweight of the branch / commit over Subversion makes Git a very interesting tool for projects that have many developpers that cannot get a meeting room for 2 hours to see what the f**k is going on with the merge conflict.

## Branch management

As I said, Git is powerful and customizable. You can design how you want to use the branches, how you want to name them. Yes, the _default_ branch is named `master` but yes you can remove it in favor to `trunk` if you prefer. You can use the `git-flow` approach to manage your development life-cycle with branches based on merging strategy. I kind of love this. `master` is my production, `dev` is my next iteration branch, `features/XX` is the development of the feature XX. If I do have production issues, I fix them in `hotfixes/YY` for the bug `YY`. Branches names disappear when the fix / feature is done (aka tested and approved) but are symbolized by a _commit of merge_.

## Back to the future

Git is also nice as you can change your history. Who wouldn't love to rewrite what they've done? You can easily do very small commits to keep in -git- mind how to achieve to develop this feature. When you finished the feature, then you can rewrite it and remove the _fixup_ commits; reorder commits give your log a logical order. I do love to `git log --oneline` and read. It can help me to understand why a random feature has been developed this way.

# The bad

> "With great power comes great responsibility"
> -- <cite>Uncle Ben</cite>

Even if you can do everything, it doesn't mean you should. I would tell you that my branch management is the one you have to use for a simple reason: it's maybe not good for your process, it could be too complicated for your team-member, even if you can learn how to use Git within 2 days.

The worst case for using Git is to use it because everyone does. I mean, migrating to Git is obvious to me, but because I see the power of Git over other VCS. And the worst way to use Git is to get one from internet "because I read it was a good one" without confronting it to your current process.

You need to understand that I don't dislike branches in my log: one "merged branch XX" commit is to me the technical speech "I think I'm done with XX". The "merged branch hotfixes/YY" is "I might not have delivered this", or "I totally forgot that people could use it".

As I said before, I read logs like a book. From the end to the beginning.

So, to come back to the _bad_ of Git, you need to define a structure on how to use it. But, even then, you won't be able to know that this structure is respected. You need to find tools that will help you control those usages. I won't point you to any of those tools, I never used them, I do not fancy those control-oriented tools very much.

To me, they are also part of the bad: don't restrict what your devs do with Git. They may find easier ways to do a release, better naming conventions, or at least some that have a meaning to them. Because, in the end, Git is a tool to make your devs life easier and they know how to do so.

# The ugly

> "The real beauty is inside"

## core.autocrlf

Well, the real ugly too. As Git is now usable from all OS, you can find `^M` in your changesets. What a useless commit! This is <u>not</u> a Git issue, this is a configuration issue.

With a correctly setup development platform, this is avoided but it seems that even in big open-source projects we are still able to find it. So please read [Git configuration - Formatting and whitespace](http://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#Formatting-and-Whitespace)

## Commit messages

There is also a kind of problem for me with logs. When using `git commit -m ""` and even `git commit` with any _out-of-the-box_ editor, you don't have any length limit. Which is very frustrating for me. Once again, I read the log. Yes I truly do! So having the "oneline" displaying a 4 lines long message is something I dislike.

You can find a lot of blog posts about "better commit messages". Linux Torvalds describe what is a commit message here: [github.com/torvalds/subsurface/README](https://github.com/torvalds/subsurface/blob/master/README#L87)

I mean, I don't always write a commit message as it is described, but have a short description of the commit and then as many text as you want to describe why you commit that. Describing what you committed is quite useless: I can read that with the diff.. But the __why__ of the commit is not in the diff.

If you ever need some help to find what could be the perfect first line for your commit message, please see [whatthecommit.com](http://whatthecommit.com/). :wink:
