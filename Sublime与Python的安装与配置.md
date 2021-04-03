# Sublime与Python的安装与配置
## Python的安装
[Python官网下载](https://www.python.org/ "Python官网")安装即可，假设安装目录为：C:/Python36

**Anaconda installer archive**：

地址1： https://repo.continuum.io/archive/

地址2：https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/

## Python包的安装
安装命令：pip install package_name  
**注意**：若没有在环境变量path中添加路径C:\Python36\Scripts的话，使用pip命令时，需先进入该目录

使用豆瓣源安装Python包，其他一些国内的源,见：<https://www.cnblogs.com/sunnydou/p/5801760.html>   
例如：pip install opencv_python -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
 
安装特定版本的包(注：版本号需写全)  
例如：pip install "tensorflow==1.14.0" -i http://pypi.douban.com/simple --trusted-host pypi.douban.com

非官方Windows版的Python扩展包下载：https://www.lfd.uci.edu/~gohlke/pythonlibs/

使用下载的安装包安装，首先进入下载文件所在的目录，然后输入安装命令  
例如：cd C:\Python36\Scripts  
pip install scikit_learn-0.19.1-cp36-cp36m-win_amd64.whl

升级原来已经安装的包(-U 是升级)  
pip install -U scikit-learn  
pip list # 查看已安装的python包  
## Sublime的安装
[Sublime官网下载](http://www.sublimetext.com/ "Sublime官网")安装即可

## Sublime的配置
**(1) 设置插件安装目录及安装Package Control**  
+ **新建插件安装目录**  
安装“Package Control”之前，在Sublime Text 3安装目录下新建data文件夹，则之后的插件就会安装到该目录下。重启Sublime，点击References --> Browser Packages就直接打开插件的安装目录。否则，插件的默认安装目录为【C:\Users\用户名\AppData\Roaming\Sublime Text 3\Packages】  
+ **安装Package Control**（可参见：https://packagecontrol.io/installation）  
从菜单 View - Show Console 或者 ctrl + ~ 快捷键，调出 console。将以下 Python 代码粘贴进去并 enter 执行，不出意外即完成安装。
```
import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```
+ **安装插件**  
快捷键 Ctrl+Shift+P（菜单 – Tools – Command Paletter），输入 install 选中Install Package并回车，输入或选择你需要的插件回车就安装了（注意左下角的小文字变化，会提示安装成功）。
+ **常用插件**  
	 - Package Control：管理插件的插件，前面已安装
	 - SublimeCodeIntel: 代码提示插件，可根据是python、java等自动代码提示
	 - SideBarEnhancements: 扩展了侧边栏中菜单选项的数量，从而提升你的工作效率
	 - SublimeTmpl：新建文件模板插件，可以支持多种语言例如Python、PHP等
	 - Terminal：打开一个命令窗口，用于各种命令操作
	 - AutoPep8：python开发规范pep8
	 - Anaconda：自动匹配关键字等实用功能，有效提高开发效率
 
**(2) SublimeRPEL快捷键设置（Python命令行）（注：需先安装SublimeREPL插件）**  
"Preferences"→"Package Settings"→"SublimeREPL"→"Settings - User"，添加以下内容
```python
{
    "default_extend_env": {"PATH": "{PATH};C:\\Python36"}
}
```
上面路径C:\\Python36为Python的安装目录。

**(3) 新建编译器：Tools——>Build System——>New Build System**  
 文件 Python36.sublime-build
```python
 { 
"cmd": ["C:/Python36/python.exe","-u","$file"], 
"file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)", 
"selector": "source.python", 
"encoding": "cp936" 
}
```
保存为Python36.sublime-build文件，存放路径默认为：C:\Sublime Text 3\Data\Packages\User\Python36.sublime-build

**(4) 设置Python模板（注：需先安装SublimeTmpl插件）**  
"Preferences"→"Package Settings"→"SublimeTmpl"→"Settings - User"，添加以下内容
```python
{  
	"disable_keymap_actions": false, // "all"; "html,css"  
	"date_format" : "%Y-%m-%d %H:%M:%S",  
	"attr": {  
	    "author": "Guosheng Kang",  
	    "email": "guoshengkang@gmail.com",  
	    "link": "https://guoshengkang.github.io"  
	}  
}
```
"Preferences"→"Package Settings"→"SublimeTmpl"→"Key Bindings - User"，添加以下内容
```python
[   
    {  
        "caption": "Tmpl: Create python", "command": "sublime_tmpl",  
        "keys": ["ctrl+alt+p"], "args": {"type": "python"}  
    },  
]
```
意思是ctrl+alt+p就可以创建一个新的Python模板  
Python的模板文件的路径为：C:\Sublime Text 3\Data\Packages\SublimeTmpl\templates\python.tmpl可自行编辑

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : ${date}
# @Author  : ${author} (${email})
# @Link    : ${link}
# @Version : \$Id\$

${1:import os}
${2:import sys}
$0
```
## Python常用包名称
+ numpy
+ scipy
+ pandas
+ matplotlib
+ sklearn
+ pymongo
+ peewee
+ pyltp 0.1.9.1
+ configparser
+ requests
+ snownlp
+ jieba
+ apscheduler
+ psycopg2
+ tensorflow
