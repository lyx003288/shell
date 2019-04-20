#!/bin/base

# ########################################################################################
# 单例脚本
# ########################################################################################
 
#文件运行实例锁文件,要唯一
LOCKFILE=/tmp/watch.lock

# 如果某条操作返回值非0，则立即退出
set -e -o noclobber
 
if [ -f ${LOCKFILE} ]
then
    # 如果单例锁文件存在并且程序正在运行,则退出（此时不会删除锁文件）。
    echo "$0 is already running"
    exit
fi
 
# 禁止重定向覆盖， 同时注入系统调用中断号，接收到中断后先删除单锁文件。
trap 'rm -f ${LOCKFILE}; echo "trap error, line: $LINENO, error cmd: $BASH_COMMAND"; exit' 1 2 3 8 9 15 ERR
 
# 把自身的pid写入单锁文件
echo $$ > ${LOCKFILE}
 
#todo 添加逻辑处理
echo "todo: add logic"
 
# 正常结束时，删除单锁文件， 此命令可以省略，因为trap捕获了正常退出信号（0），也就是说删除锁这里执行了2次
rm -f ${LOCKFILE}
