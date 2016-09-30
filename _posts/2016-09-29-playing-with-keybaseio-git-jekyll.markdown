---
layout: post
title:  "Playing with: Keybase.io, git, and Jekyll"
date:   2016-09-29 16:08:00 -0700
---

When I [recently migrated]({% post_url 2016-05-08-welcome-to-jekyll %}) to [Jekyll](https://jekyllrb.com/.), I went down the route of storing my blog in git. Since I've started to want to blog more often, I needed some way to work on posts while my main desktop was in use.

Enter [Keybase.io](https://keybase.io/). They have [kbfs](https://keybase.io/docs/kbfs) which provides me plenty of storage (10 GB) for a git repo of my blog. When I first pushed up to the repo, it took probably a few minutes to encrypt, sync, etc. But then I was able to easily clone from my work laptop, and work on another post.

Steps to set it up on my desktop:

> cd repos/becoming.wise.st
> 
> git init --bare /keybase/private/becomingwisest/becoming.wise.st.git
> 
> git remote add origin /keybase/private/becomingwisest/becoming.wise.st.git
> 
> git branch -u origin/master
> 
> git push origin master

And on my laptop, its quite easy.

> cd repos
> 
> git clone /keybase/private/becomingwisest/becoming.wise.st.git