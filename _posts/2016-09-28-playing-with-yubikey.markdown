---
layout: post
title:  "Playing with: YubiKey4"
date:   2016-09-28 22:08:00 -0700
---

Back in March, I got a [Yubikey4](https://www.yubico.com/products/yubikey-hardware/yubikey4/). I already had two of the [Github branded U2F devices](https://www.yubico.com/products/yubikey-hardware/fido-u2f-security-key/), but I've always enjoyed security and public key crypto. The YubiKey4 supports 4096 bit GPG keys, which should last a while.

I already had [GPGTools](https://gpgtools.org/) installed, so now it was a question of how to set it up. With some searching I found [Eric Severance's blog post: PGP and SSH keys on a Yubikey NEO](https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/), and used that to crib my setup. I kept failing setting it up, or at least accessing the key afeter import. With some searching, I probably found [YubiKey PIV introduction](https://developers.yubico.com/yubico-piv-tool/YubiKey_PIV_introduction.html) which provides:

> The default PIN code is 123456. The default PUK code is 12345678.
> The default 3DES management key (9B) is 010203040506070801020304050607080102030405060708.


After playing around a few times, I settled on using BF2D00BCEC46EA7B for work and personal use. I followed the directions to get my key usable with ssh via the `gpgkey2ssh` tool. I added gpg-agent support with my .bash_profile having`[[ -e /Users/christopher.evans/.gnupg/S.gpg-agent.ssh ]] && export SSH_AUTH_SOCK=/Users/christopher.evans/.gnupg/S.gpg-agent.ssh`. I actually don't remember how I get the gpg agent to start, unless its something part of the GPGTool suite.

One thing that seemed to not work is U2F. I tried adding it to my GitHub account, I tried gmail, I even tried the [demo Yubico](https://demo.yubico.com/u2f) has. No joy, time to email support. Since I gave them the guide I used, they quickly pointed out that `ykpersonalize -m82` was the right approach for YubiKey NEOs sold before September 2014. But since then U2F support has come out, and `-m86` is needed. The [ykpersonalize](https://developers.yubico.com/yubikey-personalization/Manuals/ykpersonalize.1.html) man page describes the modes:

> -m mode 
>
> set device configuration for the YubiKey. It is parsed in the form mode:cr_timeout:autoeject_timeout
>
> where mode is:
>
>0
>OTP device only.
>
>1
CCID device only.
>
>2
>OTP/CCID composite device.
>
>3
>U2F device only.
>
>4
>OTP/U2F composite device.
>
>5
>U2F/CCID composite device.
>
>6
>OTP/U2F/CCID composite device. Add 80 to set MODE_FLAG_EJECT, for example: 81
>
>cr_timeout is the timeout in seconds for the YubiKey to wait on button press for challenge response (default is 15)
>
>autoeject_timeout is the timeout in seconds before the card is automatically ejected in mode 81

With that quick fix, I now have a good GPG key, usable with SSH, and my accounts that can use U2F do. Recently Yubico has announced [Windows 10 Hello](https://www.yubico.com/2016/09/yubikey-works-windows-hello/) support, [MacOS 10.12 Sierra](https://www.yubico.com/2016/09/yubikey-smart-card-support-for-macos-sierra-2/) support, and even has a [short list of sites](https://www.yubico.com/2016/07/over-a-dozen-services-supporting-fido-u2f/) that support U2F.

