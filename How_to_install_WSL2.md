# How to install WSL2 in Windows 11 Family-version
***2025/5/9更新***   
WSL2是微软官方推出的一个可以在Windows系统下运行原生Linux系统的开发工具，本文将介绍在***Windows 11家庭版***中如何安装WSL2。

===

1. 在powershell中运行如下命令（管理员权限终端）：  
```cmd
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
出现类似`启用一个或多个功能`和`操作成功完成`等字样，即代表运行成功。  
操作完成后，务必***重启电脑！！！***

2. 更新WSL命令  
进入GitHub：`https://github.com/microsoft/WSL/releases`，找到2.5.7的Assets中的`wsl.2.5.7.0.x64.msi`文件并下载。  
下载完成后，直接点击安装即可。   
完成安装后，在powershell中运行：`wsl --set-default-version 2`。

3. 下载Ubuntu系统  
打开微软镜像网站`https://learn.microsoft.com/en-us/windows/wsl/install-manual#downloading-distributions`下载最新版本`Ubuntu 24.04`。  
下载完成后，解压该AppxBundle文件，本文使用7z解压，没有7z也可以直接更改扩展名为zip解压。解压完成后，找到`Ubuntu_2404.0.5.0_x64.appx`然后同理继续解压同名文件夹到你的磁盘中。  
双击文件夹中的ubuntu2404.exe运行

***注意！！！***

- 对于Windows 11 专业版用户来说，这里可以直接跳过，这也是为什么我要强调我用的是家庭版的原因。  
- 根据我自己设备的情况来看，直接运行会报错，专业版也可能报错，解决方法不一样：  
```text
Installing, this may take a few minutes...
WslRegisterDistribution failed with error: 0x80370114
Error: 0x80370114 ??????????????????

Press any key to continue...
``` 
- 解决方法：
  - 按 Win + R ，输入`optionalfeatures.exe`，检查
  ```text
  1. Virtual Machine Platform
  2. Windows Subsystem for Linux
  3. Hyper-V
  ```
  这三个选项是否都已钩上，如果没有就都选上，然后按照提示重启电脑。
  而对于***家庭版***用户，最大的问题是，也许设备中根本没有Hyper-V这个选项，是的，它是专业版才有。  
  - 下面就提供一个不用激活专业版Windows就能解决的方法：  
  在桌面上创建一个cmd脚本文件（不会编辑可以先创建一个txt文件再更改扩展名），命名为`Hyper-V installer.cmd`，内容为：  
  ```cmd
    pushd "%~dp0"
    dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
    for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
    del hyper-v.txt
    Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
    ```  
    保存后使用管理员身份运行该脚本。按照指示输入"Y"重启计算机。

4. 完成上述步骤后，再次点击ubuntu2404.exe运行，弹出终端窗口，信息如下：  
```text
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
For more information visit: https://aka.ms/wslusers
Enter new UNIX username: 
New password:
Retype new password:
passwd: password updated successfully
```  
设置Linux的用户名和密码，内容都随意，我在运行时还挂着VPN，此时可能会提示`wsl: 检测到 localhost 代理配置，但未镜像到 WSL。NAT 模式下的 WSL 不支持 localhost 代理。`这是正常的，忽略就好。

此时就代表WSL2安装成功！！

5. 安装net-tools, openssh-server 

先切到root权限：`sudo su root`，再输入下面的命令安装组件：
```bash
apt-get install -y net-tools openssh-server
```

再输入`ifconfig`检查是否成功
