---
layout: post
title:  "Playing with: YubiKey 4C Nano"
date:   2017-10-02 15:00:00 -0700
---

Today I got my [YubiKey 4C Nano](https://www.yubico.com/products/yubikey-hardware/yubikey4/) to join my 'new' work laptop. I figured I should follow up from my earlier post '[Playing with: YubiKey4]({% post_url 2016-09-28-playing-with-yubikey %})'. I quickly added it to [my Google account](https://myaccount.google.com/u/1/signinoptions/two-step-verification) and [GitHub](https://github.com/settings/two_factor_authentication/configure)
Back in March, I got a [Yubikey4](https://www.yubico.com/products/yubikey-hardware/yubikey4/). Next was to import my existing GPG key to the card, and make new subkeys.

First to setup the device, I launched the GUI YubiKey Manager version 1.4.1. It prompted me to set the PIN. I then selected Manage device PINs, and configured a nice long random Management Key. After these steps, commands I was using to have gpg talk to the card were failing. I pulled the device from its port, re-inserted, and gpg --card-status worked.

> Christopher:~ christopher.evans$ gpg --edit-key BF2D00BCEC46EA7B
> gpg (GnuPG/MacGPG2) 2.2.0; Copyright (C) 2017 Free Software Foundation, Inc.
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> 
> Secret key is available.
> 
> sec  rsa4096/BF2D00BCEC46EA7B
>      created: 2016-04-04  expires: 2018-05-14  usage: C
>      trust: ultimate      validity: ultimate
> ssb  rsa4096/6B9F983E43784FAA
>      created: 2016-04-04  expires: 2018-05-14  usage: E
>      card-no: 0006 04623689
> ssb  rsa4096/69B87587E27BEF4F
>      created: 2016-04-04  expires: 2018-05-14  usage: S
>      card-no: 0006 04623689
> ssb  rsa4096/E3046B22269C79D1
>      created: 2016-04-04  expires: 2018-05-14  usage: A
>      card-no: 0006 04623689
> [ultimate] (1). Christopher Evans <becomingwisest@gmail.com>
> [ultimate] (2)  Christopher Evans <christopher.evans@reachlocal.com>
> 
> gpg> addcardkey
> gpg: selecting openpgp failed: Operation not supported by device
> gpg: key operation not possible: Operation not supported by device
> 
> gpg>
> Christopher:~ christopher.evans$ gpg --card-status
> gpg: selecting openpgp failed: Operation not supported by device
> gpg: OpenPGP card not available: Operation not supported by device
> Christopher:~ christopher.evans$ gpg --card-status
> Reader ...........: Yubico Yubikey 4 OTP U2F CCID
> Application ID ...: D2760001240102010006069015360000
> Version ..........: 2.1
> Manufacturer .....: Yubico
> Serial number ....: 06901536
> Name of cardholder: [not set]
> Language prefs ...: [not set]
> Sex ..............: unspecified
> URL of public key : [not set]
> Login data .......: [not set]
> Signature PIN ....: not forced
> Key attributes ...: rsa2048 rsa2048 rsa2048
> Max. PIN lengths .: 127 127 127
> PIN retry counter : 3 0 3
> Signature counter : 0
> Signature key ....: [none]
> Encryption key....: [none]
> Authentication key: [none]
> General key info..: [none]

Setting up the PIN didn't seem to work for gpg, so I followed the [how to reset your applet on your YubiKey](https://www.yubico.com/support/knowledge-base/categories/articles/reset-applet-yubikey/) to reset the defaults.

> Christopher:~ christopher.evans$ gpg --card-status
> Reader ...........: Yubico Yubikey 4 OTP U2F CCID
> Application ID ...: D2760001240102010006069015360000
> Version ..........: 2.1
> Manufacturer .....: Yubico
> Serial number ....: 06901536
> Name of cardholder: [not set]
> Language prefs ...: [not set]
> Sex ..............: unspecified
> URL of public key : [not set]
> Login data .......: [not set]
> Signature PIN ....: not forced
> Key attributes ...: rsa2048 rsa2048 rsa2048
> Max. PIN lengths .: 127 127 127
> PIN retry counter : 0 0 3
> Signature counter : 0
> Signature key ....: [none]
> Encryption key....: [none]
> Authentication key: [none]
> General key info..: [none]
> Christopher:~ christopher.evans$ gpg-connect-agent --hex
> > scd apdu 00 20 00 81 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 82                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 82                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 82                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 20 00 83 08 40 40 40 40 40 40 40 40
> D[0000]  69 83                                              i.
> OK
> > scd apdu 00 e6 00 00
> D[0000]  90 00                                              ..
> OK
> > scd apdu 00 44 00 00
> D[0000]  90 00                                              ..
> OK
> >

I then went to see if maybe my tools were out of date, and I downloaded version 1.4.2 of [YubiKey PIV Manager](https://www.yubico.com/support/knowledge-base/categories/articles/piv-tools/) which seemed 'slow' to download, taking 2-4 minutes to download ~20 MB.

I still was messing up the PIN, but using the PIV Manager, I was able to reset the device, and assigned a PIN, and a long management key, which also allowed me to set a PUK. I skipped the Set Up YubiKey for MacOS, which would allow me to use my PIN with my key to login to my computer. This is because of FUD, I'd heard in the past that it might cause issues with gpg-agent being able to tie into the key too. And I use my finger print to login anyways, so no ease of use advantage there.

![PINEntry](/media/2017-10-02-playing-with-yubikey-4c-nano/PINEntry.png)
![DeviceInitialization](/media/2017-10-02-playing-with-yubikey-4c-nano/DeviceInitialization.png)
![SetUpYubiKeyformacOS](/media/2017-10-02-playing-with-yubikey-4c-nano/SetUpYubiKeyformacOS.png)