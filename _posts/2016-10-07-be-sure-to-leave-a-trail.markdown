---
layout: post
title:  "Note: Be sure to leave a trail"
date:   2016-10-07 21:08:00 -0700
---

As I've gained experience working in IT, I've learned to love trails left behind. When trying to figure out how a server was setup for a customer, its great when it has a runbook for them. When wondering why something was done, its great both whet the commit message goes into details of of the what and why, and any tickets related to the work. When looking at a change ticket, its great it can be linked to the story or epic.

Back in 2008, we weren't using configuration management yet, so no repeatable builds. We hadn't gotten to the point of documenting how servers got setup. Thankfully our co-worker [Grig Gheorghiu](http://agiletesting.blogspot.com/) wrote a blog post about this one step. Twice we used google and find his post [Compiling Python 2.5 with SSL support](http://agiletesting.blogspot.com/2008/05/compiling-python-25-with-ssl-support.html). Thankfully that breadcrumb was there.

Since I became the SME of puppet, being responible for the code that gets accepted in pull request, I've started to harp on commit messages. People submitting pull requests have come to learn I will ask for tickets to be listed in the commit message if there is one. Sometimes thats all they do however. One person, looking at the commit message history has 'Changes for TICKET-####'. While this at least gives a breadcrumb of information, it has lead me to try and find a good guide to pass out, and link to. My first google hit in searching found [How to Write a Git Commit Message by Chris Beams](http://chris.beams.io/posts/git-commit/).

When planning something that takes more then a unit of work, its great when the story/epic lays out the transition plan. Then tickets can be linked to the epic, or sub tasks can be created as work is found. I think this helps justify the individual work unit. People can look into why they are doing the changes, catch unexpressed assumptions, or at least know why this grind is happening.

All these trails that give either outright reasons, or at least clues as to how or why something was done is helpful.