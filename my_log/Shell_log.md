# Shell Scripts Log
## 语法类
- 第一步要做的：`#!/bin.bash`  
一个shell脚本第一步一定是设置编译工具，最常用的就是例如`#!/bin/bash`，即通过bash运行脚本。其中`#!`是一个特殊组合字符，意思为Shebang，而`/bin/bash`代表了bash存在的路径。
- 传入命令行参数变量：`TARGET_DIR=$1`  
`$1`表示命令行的第一个参数，以此类推，`$2`,`$3`等代表命令行的第2，第3...个参数。
- 对`$`符号用法的解释  
  - 变量引用：  
  ```bash
  name="Luan"
  echo "Hello,$name!"
  ```
  或者更保险的方法  
  ```bash
  name="Luan"
  echo "Hello,${name}!"
  ```
  - 特殊变量:  

  |sign|feature|
  |:--:|:--|
  |$0|脚本名|
  |$1,...|传入参数|
  |$#|命令行参数的数量|
  |$@|所有命令后参数的列表|
  |$?|上一个命令的推出状态码|

  - 命令替换，即括号里是一个返回某个值的命令：  
  ```bash
  current_date=$(date +%Y%m%d)
  echo "current date is ${current_date}"
  ```


