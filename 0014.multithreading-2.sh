#!/bin/bash

# ########################################################################################
# 多线程 - 利用wait、read命令模拟多线程
# ########################################################################################

# 此处定义任务总数量
TASK_TOTAL_NUM=13
# 此处定义线程数 
THREAD_NUM=6   

TMP_FIFOFILE="/tmp/$$.fifo" 
mkfifo $TMP_FIFOFILE    # 新建一个fifo类型的文件 
exec 6<>$TMP_FIFOFILE   # 将fd6指向fifo类型 
rm $TMP_FIFOFILE 


# 事实上就是在fd6中放置了$THREAD_NUM 个回车符 
for  ((i = 0 ;i < ${THREAD_NUM} ;i ++ ))
do
    echo
done  >& 6   
 
# 此处定义一个函数，作为一个线程(子进程) 
function sub_logic 
{  
    sleep 2
}

#  50次循环，可以理解为${TASK_TOTAL_NUM}个主机或任务
for ((i = 0 ;i < ${TASK_TOTAL_NUM}; i ++))
do   
    # 一个read -u6命令执行一次，就从fd6中减去一个回车符，然后向下执行   
    # fd6中没有回车符的时候，就停在这了，从而实现了线程数量控制 
    read -u6

    #  此处子进程开始执行，被放到后台 
    {  
        #  此处可以用来判断子进程的逻辑 
        sub_logic && {
            echo  " sub_logic is finished "
        } || {
            echo "sub_logic error"
        }

        echo >&6   #  当子进程结束以后，再向fd6中加上一个回车符，即补上了read -u6减去的那个 
    } & 
 done

wait # 等待所有的后台子进程结束           

exec 6>&-  # 关闭df6输出 
exec 6<&-  # 关闭df6输入

