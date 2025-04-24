# Linux 命令收集
## 辅助热键
- [Tab] # 命令补全，文件名补全，
- [Ctrl + C] or [Command + C] (in Mac) # 停止进程

## 工具类
***Time***
- date 
- ncal (or cal) # **If needed ,`sudo apt install ncal` please.**

***Calculate***
- bc 
  - `scale=<number>` # 决定计算器的小数点位数
  - `quit` # Exit

***System***
- `sync` # 将内存内容写入硬盘，通常在关机前的保险操作
- `shutdown[-Option][Time][Wall...]` # 操作关机，重启等
  - `[Time]`可以用24小时计时法规定到具体的时间执行，也可以用+MM规定从现在起多久执行命令。单纯执行的话默认1分钟。
  - `[WALL...]`来源于‘write all’，意于对所有用户广播某条消息
  - `shutdown -h`  # Halt the machine
  - `shutdown -r` # reboot the machine
  - `shutdown -p` # power off the machine
  - `shutdown -c` # 在以上命令执行前终止

- `systemctl`

***File***
- `chgrp` # 改变文件所属群组
- `chown` # 改变文件拥有者
- `chmod` # 改变文件权限, SUID, SGID, SBIT等特性
---
## 帮助类
- `<command> --help` # 简单的查询
- `man <command>` # 完整的查询  
**所有unix like系统都能用man指令**
  - 进入man page后，第一行会出现例如DATE(1)这样的文字，其中数字是具有含义的，重要的如下：   

  |代号|内容|
  |:---:|:---|
  |1|使用者在shell环境中可以操作的指令或可可执行文件|
  |5|配置文件或者是某些文件的格式|
  |8|系统管理员可用的管理指令|

  - `/word`在man page文档内搜索关键词，word为要替换的关键词
  - `man -f <command>` 可以显示所有可以使用的相关命令（完整的命令名称）  
  ***相当于`whatis`***
  - `man -k <incompleted command>` 可以显示所有带有该字眼的命令，通常用于忘记命令时使用   
  ***相当于`apropos`***

- `info <command>` # 类似于man，是Linux特有的一种帮助文档格式
  - 第一行显示

  |||
  |:---:|:---|
  File|文件来源
  Node|当前节点，若是Top，则表示是主节点
  Next|下一个节点，按N到下一个节点
  Prev|上一个节点，按U到上一个节点
  h|显示求助菜单
  q|结束info page

  - 光标移动到带有\*的地方，按下Enter可以进入该节点，也可以按Tab来快速选择节点

- `nano` # 简单的文本编辑器
- `who` # 用于显示当前登录用户信息
  - `who -a` # 显示所有用户信息

