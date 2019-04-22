#!/bin/bash

# ########################################################################################
# 数组遍历
# ########################################################################################

# 创建数组
 str_array=( 
     '小王'
     '小李'
     '小刘'
)

# 方法一 利用#${#array[@]}获得数组的长度
for (( i = 0; i < ${#str_array[@]}; i++ )) 
do
    echo "str_array index=${i}, value=${str_array[i]}"
done


# 创建数组
int_array=(3 4 5 6 7)

# 方法二 也可以写成 for element in ${array[*]}
for element in ${int_array[@]}
do
    echo int_array value=$element
done
