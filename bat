@echo off
rem -------------------------------------------------------------------------
rem BME Encrypt Script 
rem -------------------------------------------------------------------------

@if not "%ECHO%" == ""  echo %ECHO%
@if "%OS%" == "Windows_NT"  setlocal

set DIRNAME=.\
if "%OS%" == "Windows_NT" set DIRNAME=%~dp0%
set PROGNAME=run.bat
if "%OS%" == "Windows_NT" set PROGNAME=%~nx0%

set BME_HOME=..\..

rem -------------------------------------------------------------------------
set OPTIONS=aes-encryption.jar
rem -------------------------------------------------------------------------

if not "%JAVA_HOME%" == "" goto ADD_TOOLS

set JAVA=java

echo JAVA_HOME is not set.  Unexpected results may occur.
echo Set JAVA_HOME to the directory of your local JDK to avoid this message.
goto SKIP_TOOLS

:ADD_TOOLS

set JAVA=%JAVA_HOME%\bin\java

if exist "%JAVA_HOME%\lib\tools.jar" goto SKIP_TOOLS
echo Could not locate %JAVA_HOME%\lib\tools.jar. Unexpected results may occur.
echo Make sure that JAVA_HOME points to a JDK and not a JRE.

:SKIP_TOOLS

rem Include the JDK javac compiler for JSP pages. The default is for a Sun JDK
rem compatible distribution to which JAVA_HOME points

set JAVAC_JAR=%JAVA_HOME%\lib\tools.jar

rem If EXE_CLASSPATH is empty, don't include it, as this will 
rem result in including the local directory, which makes error tracking
rem harder.
if "%EXE_CLASSPATH%" == "" (
	set EXE_CLASSPATH=%JAVAC_JAR%;%OPTIONS%
) ELSE (
	set EXE_CLASSPATH=%EXE_CLASSPATH%;%JAVAC_JAR%;%OPTIONS%
)

rem Setup JBoss specific properties
set JAVA_OPTS=%JAVA_OPTS% -Dprogram.name=%PROGNAME%

rem set JAVA_OPTS=%JAVA_OPTS% -Xms128m -Xmx512m

rem "%JAVA%" %JAVA_OPTS% -classpath "%EXE_CLASSPATH%" com.qingyuan.huake.commons.encryption.CommonTool %*
rem @java -classpath . Crack
rem @pause

%0

:END



// 原则规范很重要
// <[http://blog.chinaunix.net/uid-7747097-id-2562084.html]>
在多线程条件下,函数应当是线程安全的,进一步,更强的条件是可重入的,可重入函数保证了
在多线程条件下, 函数的状态不会出现错误:
static int tmp;
void func1(int* x, int* y) {
    tmp=*x; 
    *x=*y; 
    *y=tmp;
}
void func2(int* x, int* y) {
    int tmp; 
    tmp=*x; 
    *x=*y; 
    *y=tmp;
}

函数编写规范:
a) 对所调用函数的错误返回码要仔细,全面的处理;
b) 明确函数功能,精确(而不是近似)地实现函数设计;
c) 编写可重入函数时,应该注意局部变量的使用,不应使用static局部变量,否则必须经过特殊处理,才能使函数具有可重入性
d) 编写可重入函数时,若使用全局变量,则应该通过中断,信号量(p,v操作)等手段对其加以保护
e) 在同一项目组应该明确规定对接口函数参数的合法性检查应由函数的调用者负责还是由接口函数本身负责,缺省是由函数
   调用者负责;
f) 防止将函数的参数作为工作变量 
说明：将函数的参数作为工作变量,有可能错误地改变参数内容,所以很危险,对必须改
变的参数,最好先用局部变量代之,最后再将该局部变量的内容赋给该参数  
void sum_data( unsigned int num, int *data, int *sum )
{
    unsigned int count ;
    int sum_temp;
    sum_temp = 0;
  
    for (count = 0; count < num; count ++)
    {
        sum_temp  += data[count]; 
    }
  
    *sum = sum_temp;
}
g): 函数的规模尽量限制在 200 行以内,不包括注释和空格行
h): 一个函数仅完成一件事
i): 为简单功能编写函数 
j): 不要设计多用途面面俱到的函数说明：多功能集于一身的函数,很可能使函数的理解,测试,维护等变得困难 
k): 函数的功能应该是可以预测的，也就是只要输入数据相同就应产生同样的输出
l): 尽量不要编写依赖于其他函数内部实现的函数
m): 避免设计多参数函数,不使用的参数从接口中去掉说明：目的减少函数间接口的复杂度
n): 非调度函数应减少或防止控制参数,尽量只使用数据参数 
o): 检查函数所有参数输入的有效性,检查函数所有非参数输入的有效性,如数据文件,公共变量等 
p): 函数名应准确描述函数的功能 
q): 使用动宾词组为执行某操作的函数命名,如果是OOP 方法,可以只有动词(名词是对象本身)
r): 避免使用无意义或含义不清的动词为函数命名避免用含义不清的动词如process、handle等为函数命名
    因为这些动词并没有说明要具体做什么
s): 如果多段代码重复做同一件事情,那么在函数的划分上可能存在问题 
t): 功能不明确较小的函数,特别是仅有一个上级函数调用它时,应考虑把它合并到上级函数中,而不必单独存在
u): 改进模块中函数的结构,降低函数间的耦合度,并提高函数的独立性以及代码可读性效率和可维护性 
优化函数结构时，要遵守以下原则： 
不能影响模块功能的实现
仔细考查模块或函数出错处理及模块的性能要求并进行完善
通过分解或合并函数来改进软件结构
考查函数的规模,过大的要进行分解
降低函数间接口的复杂度
不同层次的函数调用要有较合理的扇入,扇出
函数功能应可预测
提高函数内聚
