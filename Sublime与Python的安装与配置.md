# Sublime与Python的安装与配置
## Python的安装
[Python官网下载](https://www.python.org/ "Python官网")安装即可，假设安装目录为：C:/Python36
## Python包的安装
安装命令：pip install package_name  
**注意**：若没有在环境变量path中添加路径C:\Python36\Scripts的话，使用pip命令时，需先进入该目录

使用豆瓣源安装Python包，其他一些国内的源,见：<https://www.cnblogs.com/sunnydou/p/5801760.html>   
例如：pip install opencv_python -i http://pypi.douban.com/simple --trusted-host
 
安装特定版本的包(注：版本号需写全)  
例如：pip install "pyltp==0.1.9.1" -i http://pypi.douban.com/simple --trusted-host pypi.douban.com

使用下载的安装包安装，首先进入下载文件所在的目录，然后输入安装命令  
例如：cd C:\Python36\Scripts  
pip install scikit_learn-0.19.1-cp36-cp36m-win_amd64.whl

## Sublime的安装
[Sublime官网下载](http://www.sublimetext.com/ "Sublime官网")安装即可

## Sublime的配置
**(1) 设置插件安装目录及安装Package Control**  
安装“Package Control”之前，在Sublime Text 3安装目录下新建data文件夹，则之后的插件就会安装到该目录下。重启Sublime，点击References --> Browser Packages就直接打开插件的安装目录。否则，插件的默认安装目录为【C:\Users\用户名\AppData\Roaming\Sublime Text 3\Packages】  
Package Control的安装：https://packagecontrol.io/installation

(2) SublimeRPEL快捷键设置（Python命令行）
"Preferences"→"Package Settings"→"SublimeREPL"→"Settings - User"，添加以下内容
```python
{
    "default_extend_env": {"PATH": "{PATH};C:\\Python36"}
}
```
上面路径C:\\Python36为Python的安装目录。

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
