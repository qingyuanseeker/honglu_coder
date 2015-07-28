
what hurts more, the pain of hard work or the pain of regret ?
No town can never be home; yet the past can never be back. 
没有留不下的城市,只有回不去的过往

人要善于发现问题，才能更好地解决问题
分析原因，做好应对
解决问题要解决核心问题

学以致用,需求驱动学习 >>> <[ant 与 maven 学习与应用::]>
Dos 命令删除添加新服务:
-- 新增服务
sc create Svnservice binpath="d:\subversion\bin\svnservice.exe --service -r E:\projectversion"
   displayname="Svenservice" depend=Tcpip
-- 删除服务
sc delete Svnservice
-- 修改配置
sc config Svnservice binpath="d:\subversion\bin\svnservice.exe --service -r E:\projectversion"
   displayname="Svnservice" depend=Tcpip 
-- 设置自启动
sc config Svnservice start=auto
-- 启动服务
net start Svnservice   

C:\Users>net view| findstr xiangmeng >> \\XWX890307C xiangmengPC
C:\Users>ping XWX890307C >> ping -a 目标IP地址 nbtstat -a

对于有些应用程序,使用时,总是要先启动服务,比如: oracle,svn,weblogic...
我们如何通过命令,把这启动服务的命令添加进服务呢? 达到开机的时候服务就自动启动了,
而不是非得别人来提醒要启动某某服务...

C:\Users>net start
C:\Users>sc /?
SC 是用于与服务控制管理器和服务进行通信的命令行程序
delete----------(从注册表)删除服务
create----------创建服务(将其添加到注册表)

在 Linux 或unix 平台上,可以使用如下命令将Oracle JDBC文件加入到$CLASSPATH 环境变量中:
#  export set CLASSPATH=$ORACLE_HOME/jdbc/lib/ojdbc6.jar;.:$CLASSPATH
在 windows 平台为:
set CLASSPATH="ORACLE_HOME"\jdbc\lib\ojdbc6.jar;.:%CLASSPATH%

UNDO和REDO表空间 <jvm -opt 参数类似问题::> 
oralce 编程规范 & oracle 性能调优 >>> 好好学习
http://blog.chinaunix.net/uid-57485-id-3171219.html
