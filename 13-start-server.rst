操练：启动新月杀服务器
======================

Linux的预备内容已经结束了，我们来开服吧。这下终于能回到windows了。

不过声明一点，你只是在windows下操作而已，实际上还是在和Linux打交道——只是不用再在虚拟机里面了，复制粘贴变得更加方便了。

在虚拟机启动SSH服务器
---------------------

（如果已经买了云服务器，跳过这一步。）

虚拟机和你的真机本质上是一台机器，所以互相连接自然没的说。

先在虚拟机准备好ssh操作环境，安装：

::

   $ apt install openssh-server net-tools

好，都安装完成之后，接下来查看虚拟机的本机IP地址。

::

   $ /usr/sbin/ifconfig

.. figure:: pic/13-1.jpg
   :align: center

   用ifconfig查看IP地址，划线的那个inet 192.168.xxx.xxx就是虚拟机的地址

还没完呢！我们还要启动ssh服务端程序才行。先su到root里面，然后命令：

::

   $ systemctl start sshd

OK，至此虚拟机那边的事情就搞定了。

SSH进自己的服务器机器
----------------------

接下来是Windows时间了，然而话题依然和终端离不开。简而言之，我们需要安装一个ssh客户端。

关于Windows平台的SSH客户端，网上有很多说法，vscode也有ssh客户端插件使用。但我这里还是介绍一下git bash。

前往\ `官网 <https://git-scm.com/download/win>`__\ 下载git，下载64-bit
Git for Windows Setup。这样应该会为您下载一个exe安装包。

考虑到官网的下载链接实际上指向github，而且可能连官网的都进不去，所以也考虑\ `从清华源下载Git <https://mirrors.tuna.tsinghua.edu.cn/github-release/git-for-windows/git/>`__\ 。

下载完git后安装即可，安装成功后，在文件管理器里面右键应该会出现“Git bash here”。点击打开bash就行。bash的基本使用办法已经在前两篇聊过了，ls之类的命令用法都一样。

总之，我们还是ssh到机器里面为好：

::

  $ ssh notify@192.168.235.142
  >>> The authenticity of host '192.168.235.142 (192.168.235.142)' can't be established.
  ED25519 key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
  This key is not known by any other names.
  Are you sure you want to continue connecting (yes/no/[fingerprint])? 

像这样，给ssh命令带个参数，参数格式是“用户名@主机的IP地址”。（如果是直接连云服务器的话，那用户名就是root了，IP填你的云服务器IP，root的密码理应已经知道了）

然后他询问是否继续连接，这里不能直接回车，手动敲个yes进去。之后询问输入密码，输入正确的密码就行了。

::

  Warning: Permanently added '192.168.235.142' (ED25519) to the list of known hosts.
  notify@192.168.235.142's password: 
  Linux debian 6.1.0-11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.38-4 (2023-08-08) x86_64

  The programs included with the Debian GNU/Linux system are free software;
  the exact distribution terms for each program are described in the
  individual files in /usr/share/doc/*/copyright.

  Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
  permitted by applicable law.
  notify@debian:~$ 

出现了命令提示符了，此时我们就可以开始操作了，就像直接操作Linux机器那样。

（虚拟机的话先su到root并cd ~再操作，云服务器不必）

编译运行新月杀服务器端
-----------------------

安装依赖：（云服务器一般最新只到debian 11，想安装的话需要先换源到debian12并apt update和apt upgrade）

::

   $ apt install git gcc g++ cmake liblua5.4-dev libsqlite3-dev libreadline-dev libssl-dev libgit2-dev swig qt6-base-dev qt6-tools-dev-tools

下载新月杀源码：

::

   $ git clone https://gitee.com/notify-ctrl/FreeKill

编译。

::

   $ cd FreeKill
   $ mkdir build
   $ cd build
   $ cp -r /usr/include/lua5.4/* ../include
   $ cmake .. -DFK_SERVER_ONLY=
   $ make

运行。

::

   $ cd ..
   $ ln -s build/FreeKill
   $ ./FreeKill -s
   08/14 14:46:33 Main[I] Server is listening on port 9527
   FreeKill, Copyright (C) 2022-2023, GNU GPL'd, by Notify et al.
   This program comes with ABSOLUTELY NO WARRANTY.
   This is free software, and you are welcome to redistribute it under
   certain conditions; For more information visit http://www.gnu.org/licenses.
   
   [v0.3.3] This is server cli. Enter "help" for usage hints.
   fk>

至此成功的运行了。输入quit命令退出新月杀自己的shell，回到Linux shell。

在quit之前你也可以先用本机试试水，在windows启动新月杀，然后试着用虚拟机或者云服务器的IP连接一下服务器。

（云服务器需要为防火墙放行9527号端口，TCP和UDP都要放行）

把服务器挂在后台吧
------------------

如果直接在SSH挂着服务器的话，SSH连接会在一段时间不操作之后自己断掉，这时候服务器也就自己关了。此时需要用到screen命令，创建一个挂后台的进程。

没有screen的话先用apt安装，有的话直接单走一个screen命令。

进入screen后就像是开启了新的终端一样。在screen内部用同样的方法启动服务器吧。

操作完了之后，按下Ctrl+A，再按下Ctrl+D，服务器就被挂到后台了。此时我们用exit命令退出登陆也没关系。

后面登陆进来之后又要重新把新月服务器调到前台。此时我们用screen -r命令。

这样一来挂起的服务器就又回到前台了。一样的，我们用ctrl+a ctrl+d再把他挂起来。

有关screen的更加详细玩法，请自己上网查询资料吧。
