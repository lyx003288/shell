#!/bin/bash

# ########################################################################################
# 判断一个变量是否为数字
# ########################################################################################

function checkInt_1()
{
    expr $1 + 0 &> /dev/null
    [ $? -ne 0 ] && { echo "Args $1 is not integer!"; } || { echo "Args $1 is integer!"; }
}

function checkInt_2()
{
    tmp=`echo $1 | sed 's/[0-9]//g'`
    { [ -n "${tmp}" ] || [[ "${tmp:0:1}" = "-" ]]; } && { echo "Args $1 is not integer!"; } || { echo "Args $1 is integer!"; }
}


echo "method 1 =============================="
checkInt_1 123 
checkInt_1 123a
checkInt_1 -123
checkInt_1 -123a

echo "method 2 =============================="
checkInt_2 123 
checkInt_2 123a
checkInt_2 -123
checkInt_2 -123a