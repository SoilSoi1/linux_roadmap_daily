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
---
## 文件类
***File***
- `chgrp` # 改变文件所属群组
- `chown` # 改变文件拥有者
- `chmod` # 改变文件权限, SUID, SGID, SBIT等特性  


***文件路径***
|sign|description|
|:---:|:---|
|.|此层目录|
|..|上层目录|
|\-|代表前一个工作目录(*少见*)|
|~|“目前使用者的主文件夹”|

- `cd` # change directory
- `pwd` # print working directory 显示当前所在目录
  - -P 显示物理路径 
- `mkdir` # 创建新目录
  - -p # 递回创建文件夹，即一次创建多级目录
  - -m # 设定文件权限  
  举例：`mkdir -m 711 test2`这个命令在创建文件目录test2时，规定了文件的权限。  
  介绍一下权限的八进制表示：  
    - 4: read
    - 2: write
    - 1: execute 执行权限

    所以711表示user有rwx权限（1+2+4），group和others只有--x权限。
- `rmdir` # 删除空目录
  - -p # 连同上层空目录一起删除

- `ls` # 默认显示非隐藏文件文件名，并以文件名进行排序
  - `-a` # 全部文件，包括隐藏文件
  - `-A` # 全部文件，除了./ 和 ../ 这两个目录 ***在macos上不一样，具体查询`man ls`, 在mac上-A包括了 ./ 和 ../，而-a只包括了./***
  - `-d` # 只列出目录本身
  - `-i` # 列出inode代码
  - `-l` # 长数据串列出，包括文件属性和使用权限
  - `-R` # 连同子目录内容一同列出
  - `-t` # 依时间排序

- `cp` # 复制
  - `-a` 相当于`-dr`，此操作不会因为复制而改变文件的属性，例如修改时间等
  - `-d` 若来源文件为链接文件的属性（link file），则复制链接文件属性而非文件本身
  - `-r` 递回复制，用于复制目录
  - `-f` 强制
  - `-u` 目标与源不一致时，才进行复制。   

- `basename [path]`和`dirname [path]` # 获取路径文件名称和目录名称

***文件内容查询***
```bash
cat # 由第一行开始显示文件内容
tac # 从最后一行开始显示内容，是cat的倒写！
more # 一页一页地显示内容
less # more的加强版，可以往前翻页
head # 只看头几行
tail # 只看尾巴几行
od # 以二进制方式读取文件内容
```
在more或者man等查看文档的时候，输入/可以查询字符串。

***环境变量***  
环境变量允许在任何地方执行一个可执行文件，使用`echo $PATH`查询有哪些目录被定义出来。在su模式下，会弹出形如`/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin`这样的内容，其中用冒号：来表示分隔。在linux中，/bin是链接到/usr/bin中去的。  
添加环境变量的方法：  
```command
PATH="${PATH}:/root"
```
可以类比python，这么理解：PATH就是一个系统内置的字符串，${}类似于f-string的用法，用于在字符串中格式化变量，最终在PATH这个字符串变量最后添上":/root"路径，从而组成一个完整的环境变量路径名。

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
