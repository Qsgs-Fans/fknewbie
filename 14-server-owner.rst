操练：作为一名服主
===================

以上都只是启动服务器而已，但服务器处于空白的状态。此时你作为一名服主，应当自己去打理服务器了。

这篇文章介绍关于打理新月杀服务器的种种方式。在阅读之前，你应该先明白服主自身的责任：

1. 尊重他人的隐私。
2. 操作之前，还请三思。
3. 能力越大，责任也越大。

那么我们开始吧。

在新月杀自己的shell中使用help命令即可阅读各种帮助：

::

  fk> help
  08/14 14:57:37 Shell[I] Running command: "help"
  08/14 14:57:37 Shell[I] Frequently used commands:
  08/14 14:57:37 Shell[I] help: Display this help message.
  08/14 14:57:37 Shell[I] quit: Shut down the server.
  08/14 14:57:37 Shell[I] crash: Crash the server. Useful when encounter dead loop.
  08/14 14:57:37 Shell[I] lsplayer: List all online players.
  08/14 14:57:37 Shell[I] lsroom: List all running rooms.
  08/14 14:57:37 Shell[I] reloadconf/r: Reload server config file.
  08/14 14:57:37 Shell[I] kick: Kick a player by his <id>.
  08/14 14:57:37 Shell[I] msg/m: Broadcast message.
  08/14 14:57:37 Shell[I] ban: Ban 1 or more accounts, IP, UUID by their <name>.
  08/14 14:57:37 Shell[I] unban: Unban 1 or more accounts by their <name>.
  08/14 14:57:37 Shell[I] banip: Ban 1 or more IP address. At least 1 <name> required.
  08/14 14:57:37 Shell[I] unbanip: Unban 1 or more IP address. At least 1 <name> required.
  08/14 14:57:37 Shell[I] banuuid: Ban 1 or more UUID. At least 1 <name> required.
  08/14 14:57:37 Shell[I] unbanuuid: Unban 1 or more UUID. At least 1 <name> required.
  08/14 14:57:37 Shell[I] resetpassword/rp: reset <name>'s password to 1234.
  08/14 14:57:37 Shell[I]
  08/14 14:57:37 Shell[I] ===== Package commands =====
  08/14 14:57:37 Shell[I] install: Install a new package from <url>.
  08/14 14:57:37 Shell[I] remove: Remove a package.
  08/14 14:57:37 Shell[I] lspkg: List all packages.
  08/14 14:57:37 Shell[I] enable: Enable a package.
  08/14 14:57:37 Shell[I] disable: Disable a package.
  08/14 14:57:37 Shell[I] upgrade/u: Upgrade a package. Leave empty to upgrade all.
  08/14 14:57:37 Shell[I] For more commands, check the documentation.

help命令会列出所有的操作方法。一一说明吧。

拓展包管理相关
---------------

新月杀提供了六条管理拓展包的命令。help里面已经说的很明白了。

欲安装拓展包，需使用install命令，参数是那个拓展包的git链接。

欲删除、启用、禁用拓展包，需要带拓展包的名字作为命令参数。

欲查询拓展包，使用lspkg命令。更新则是upgrade命令。

人员管理相关
-------------

使用ban命令即可封禁用户，使用他的用户名作为参数。

ban命令会同时封禁用户名和设备码。

使用banip命令可以封禁用户的ip地址，参数一样的是用户名。

同理，unban和unbanip命令可以解封相应的用户。

如果用户因为逃跑被自动封禁，则无法使用除了重启之外的任何手段解封。

其他命令
--------

msg命令可以向全服发送通告，参数就是通告内容。

resetpassword命令可以将用户的密码重置为1234。

reloadconf可以重新加载服务器端的配置文件。

关于服务器的配置文件
---------------------

除了那些命令之外，服主还可以用配置文件对服务器进行定制。

先将游戏目录下的配置样例复制一份：

::

   $ cp freekill.server.config.json.example freekill.server.config.json

然后使用nano编辑freekill.server.config.json吧，默认内容如下：

.. code:: json

    {
      "banwords": [],
      "description": "FreeKill Server",
      "iconUrl": "https://img1.imgtp.com/2023/07/01/DGUdj8eu.png",
      "capacity": 100,
      "tempBanTime": 20,
      "motd": "Welcome!",
      "hiddenPacks": []
    }

编辑他们即可修改服务器的相关设置，各项含义如下：

- banwords: 字符串数组，服务器的违禁词汇列表。违禁词发不出去也不能作为用户名/房间名。
- description: 服务器简介，显示在加入服务器界面的那行文字。
- iconUrl: 服务器图标对应的图片链接，必须是网络图片。
- capacity: 服务器最大承载玩家的容量。
- tempBanTime: 对于逃跑玩家的自动封禁时长，单位为分钟。
- motd: 用户进入大厅时候在屏幕右侧看到的文字，支持markdown格式。
- hiddenPacks: 服务器想要隐藏的拓展包列表，对于DIY服应该是需要的。
