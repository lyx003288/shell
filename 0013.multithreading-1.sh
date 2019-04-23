#!/bin/bash

# ########################################################################################
# 多线程
# ########################################################################################

# 任务的数量
all_num=11

# 并发的线程数量
thread_num=5


# 方法一 wait命令会等待当前脚本进程下的子进程结束，再运行后面的语句。
echo "method 1 start"
for num in `seq 1 ${all_num}`
do
{
    sleep 1
    echo "num is ${num}"
} &
done

wait

# 方法二 此例子说明了一种用wait、read命令模拟多线程的一种技巧，参见 0014


# 方法三 
# xargs命令有一个-P参数，表示支持的最大进程数，默认为1。为0时表示尽可能地大
# sh -c参数可以将字符串当脚本执行

echo "method 3 start"
seq 1 ${all_num} | xargs -n 1 -I {} -P ${thread_num} sh -c "sleep 1; echo {}"

# 方法四 
# GNU parallel命令是非常强大的并行计算命令，使用-j参数控制其并发数量。
# parallel使用前需要安装
echo "method 4 start"
parallel -j ${thread_num} "sleep 1; echo {}" ::: `seq 1 ${all_num}`