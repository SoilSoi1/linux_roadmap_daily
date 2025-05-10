# SSH: How to Connect Windows 11 and MacOS
---  
## 1. 在Windows上安装OpenSSH Server  
首先用管理员权限打开powershell，输入命令：
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
会有进度条提示。  
随后，启用服务：  
```powershell
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```
`Automatic`选项的意思是让ssh服务开机自启动。

如果开启了防火墙，还需要开放22端口：  
```powershell
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' `
    -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

## 2. 在mac上测试ssh是否可以连接  
输入命令：  
```bash
# ssh后面的内容替换成你要连接的Windows地址
ssh your_windows_username@windows_IP
```
这里要注意两点：
- 如果你的Windows没有密码，请设置一个密码，ssh不允许无密码用户连接。无密码状态下连接ssh会permission denied
- 找到你要连接的用户名，比如我的主机叫DELLPC，那么ssh后面的内容就是`DELLPC@192.168.1.xxx`，后面的ip地址可以在powershell中输入`ipconfig`查看，找到IPv4那一栏的就行。

正常情况下这样就可以连接到主机使用了，你的mac终端就会变成Windows终端。

## 一些小问题
- 默认打开cmd而不是powershell，这个问题有两个解决方法：
  - 连接ssh时在后面加"powershell"，即`ssh name@ip "powershell"`。
  - 打开默认cmd窗口后输入powershell。
- 出现???乱码：  
终端字符编码不一致
，在mac上连接ssh后，立刻输入`chcp 65001`,出现`Acitive code page: 65001`即可。
- 无法与终端交互，例如方向键选取历史命令：
  - 连接ssh时加一个选项`-t`，这表示为远程命令分配一个伪终端，这会恢复终端交互功能
  - 添加ssh配置：  
  ```bash
  nano ~/.ssh/config # 没有文件会自动创建
  ```
  ```nano
  Host dellpc
    HostName 100.xxx.xxx.xxx
    User DELLPC
    RequestTTY yes
  ```
  此时只要在bash里输入`ssh dellpc`就可以直接进入，当然之前的方法也可以，不冲突。