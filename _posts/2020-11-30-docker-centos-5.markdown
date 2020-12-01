---
layout: post
title:  "Docker CentOS 5"
date:   2020-11-30 16:12:00 -0800
---

I need to do some migration work related to CentOS 5. And I was hitting an issue with **"Error: Cannot find a valid baseurl for repo: base"**

TLDR:
```
sed -i /mirrorlist/d /etc/yum.repos.d/*repo
sed 's_^#baseurl=http://mirror.centos.org/centos/$releasever_baseurl=https://vault.centos.org/5.11/_' -i /etc/yum.repos.d/*repo
```

Here is how I start the container.
```
docker run -it --rm centos:5
```
Example update:
```
[root@db903e4a4ff2 /]# yum update
Loaded plugins: fastestmirror
Determining fastest mirrors
YumRepo Error: All mirror URLs are not using ftp, http[s] or file.
 Eg. Invalid release/repo/arch combination/
removing mirrorlist with no valid mirrors: /var/cache/yum/base/mirrorlist.txt
Error: Cannot find a valid baseurl for repo: base
[root@db903e4a4ff2 /]# sed -i /mirrorlist/d /etc/yum.repos.d/*repo
[root@db903e4a4ff2 /]# sed 's_^#baseurl=http://mirror.centos.org/centos/$releasever_baseurl=https://vault.centos.org/5.11/_' -i /etc/yum.repos.d/*repo
[root@db903e4a4ff2 /]# yum update
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
base                                                                                                                          | 1.1 kB     00:00
base/primary                                                                                                                  | 1.3 MB     00:01
base                                                                                                                                       3667/3667
extras                                                                                                                        | 2.1 kB     00:00
extras/primary_db                                                                                                             | 173 kB     00:00
libselinux                                                                                                                    | 1.9 kB     00:00
libselinux/primary_db                                                                                                         | 128 kB     00:00
updates                                                                                                                       | 1.9 kB     00:00
updates/primary_db                                                                                                            | 1.0 MB     00:01
Reducing CentOS-5 - libselinux to included packages only
Finished
Setting up Update Process
Resolving Dependencies
--> Running transaction check
---> Package bind-libs.x86_64 30:9.3.6-25.P1.el5_11.12 set to be updated
---> Package bind-utils.x86_64 30:9.3.6-25.P1.el5_11.12 set to be updated
---> Package nspr.x86_64 0:4.11.0-1.el5_11 set to be updated
---> Package nss.x86_64 0:3.21.3-2.el5_11 set to be updated
---> Package openssl.x86_64 0:0.9.8e-40.el5_11 set to be updated
---> Package tzdata.x86_64 0:2017b-1.el5 set to be updated
--> Finished Dependency Resolution

Dependencies Resolved

=====================================================================================================================================================
 Package                          Arch                         Version                                           Repository                     Size
=====================================================================================================================================================
Updating:
 bind-libs                        x86_64                       30:9.3.6-25.P1.el5_11.12                          updates                       902 k
 bind-utils                       x86_64                       30:9.3.6-25.P1.el5_11.12                          updates                       181 k
 nspr                             x86_64                       4.11.0-1.el5_11                                   updates                       123 k
 nss                              x86_64                       3.21.3-2.el5_11                                   updates                       1.3 M
 openssl                          x86_64                       0.9.8e-40.el5_11                                  updates                       1.7 M
 tzdata                           x86_64                       2017b-1.el5                                       updates                       757 k

Transaction Summary
=====================================================================================================================================================
Install       0 Package(s)
Upgrade       6 Package(s)

Total download size: 4.9 M
Is this ok [y/N]: y
Downloading Packages:
(1/6): nspr-4.11.0-1.el5_11.x86_64.rpm                                                                                        | 123 kB     00:00
(2/6): bind-utils-9.3.6-25.P1.el5_11.12.x86_64.rpm                                                                            | 181 kB     00:00
(3/6): tzdata-2017b-1.el5.x86_64.rpm                                                                                          | 757 kB     00:00
(4/6): bind-libs-9.3.6-25.P1.el5_11.12.x86_64.rpm                                                                             | 902 kB     00:00
(5/6): nss-3.21.3-2.el5_11.x86_64.rpm                                                                                                       | 1.3 MB     00:01
(6/6): openssl-0.9.8e-40.el5_11.x86_64.rpm                                                                                                                            | 1.7 MB     00:01
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                        802 kB/s | 4.9 MB     00:06
warning: rpmts_HdrFromFdno: Header V3 DSA signature: NOKEY, key ID e8562897
updates/gpgkey                                                                                                                                                        | 1.5 kB     00:00
Importing GPG key 0xE8562897 "CentOS-5 Key (CentOS 5 Official Signing Key) <centos-5-key@centos.org>" from /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
Is this ok [y/N]: y
Running rpm_check_debug
Running Transaction Test
Finished Transaction Test
Transaction Test Succeeded
Running Transaction
  Updating       : openssl                                                                                                                                                              1/12
  Updating       : bind-libs                                                                                                                                                            2/12
  Updating       : nspr                                                                                                                                                                 3/12
  Updating       : nss                                                                                                                                                                  4/12
  Updating       : bind-utils                                                                                                                                                           5/12
  Updating       : tzdata                                                                                                                                                               6/12
  Cleanup        : bind-utils                                                                                                                                                           7/12
  Cleanup        : nss                                                                                                                                                                  8/12
  Cleanup        : bind-libs                                                                                                                                                            9/12
  Cleanup        : openssl                                                                                                                                                             10/12
  Cleanup        : nspr                                                                                                                                                                11/12
  Cleanup        : tzdata                                                                                                                                                              12/12

Updated:
  bind-libs.x86_64 30:9.3.6-25.P1.el5_11.12   bind-utils.x86_64 30:9.3.6-25.P1.el5_11.12   nspr.x86_64 0:4.11.0-1.el5_11   nss.x86_64 0:3.21.3-2.el5_11   openssl.x86_64 0:0.9.8e-40.el5_11
  tzdata.x86_64 0:2017b-1.el5

Complete!
[root@db903e4a4ff2 /]#
```
