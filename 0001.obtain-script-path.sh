#!/bin/bash

# ########################################################################################
# 获得当前脚本的绝对路径
# ########################################################################################

# 方法一
readonly absolute_path_1=$(cd `dirname $0`; pwd)
echo $absolute_path_1

# 方法二
readonly absolute_path_2=$(dirname `readlink -f "$0"`)
echo $absolute_path_2
