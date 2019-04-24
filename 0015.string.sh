#!/bin/bash

# ########################################################################################
# 常规字符串操作 - shell中的字符串操作的处理方法很多，根据需要灵活选择。
# 这里只列出一些比较常用与使用的操作。
#
# 一、判断读取字符串值
# ${var}	变量var的值, 与$var相同
# 	 
# ${var-DEFAULT}	如果var没有被声明, 那么就以$DEFAULT作为其值 *
# ${var:-DEFAULT}	如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
# 	 
# ${var=DEFAULT}	如果var没有被声明, 那么就以$DEFAULT作为其值 *
# ${var:=DEFAULT}	如果var没有被声明, 或者其值为空, 那么就以$DEFAULT作为其值 *
# 	 
# ${var+OTHER}	    如果var声明了, 那么其值就是OTHER, 否则就为null字符串
# ${var:+OTHER}	    如果var被设置了, 那么其值就是OTHER, 否则就为null字符串
# 	 
# ${var?ERR_MSG}	如果var没被声明, 那么就打印$ERR_MSG *
# ${var:?ERR_MSG}	如果var没被设置, 那么就打印$ERR_MSG *
# 	 
# ${!varprefix*}	匹配之前所有以varprefix开头进行声明的变量
# ${!varprefix@}	匹配之前所有以varprefix开头进行声明的变量
#
# 二、字符串操作（长度，读取，替换）
# ${#string}	                    $string的长度
# 	 
# ${string:position}	            在$string中, 从位置$position开始提取子串
# ${string:position:length}	        在$string中, 从位置$position开始提取长度为$length的子串
# 	 
# ${string#substring}	            从变量$string的开头, 删除最短匹配$substring的子串
# ${string##substring}	            从变量$string的开头, 删除最长匹配$substring的子串
# ${string%substring}	            从变量$string的结尾, 删除最短匹配$substring的子串
# ${string%%substring}	            从变量$string的结尾, 删除最长匹配$substring的子串
#
# ${string/substring/replacement}	使用$replacement, 来代替第一个匹配的$substring
# ${string//substring/replacement}	使用$replacement, 代替所有匹配的$substring
# ${string/#substring/replacement}	如果$string的前缀匹配$substring, 那么就用$replacement来代替匹配到的$substring
# ${string/%substring/replacement}	如果$string的后缀匹配$substring, 那么就用$replacement来代替匹配到的$substring
# ########################################################################################

string='abcdefghijklmnopqrstuvwxyz'
echo 'str=abcdefghijklmnopqrstuvwxyz'

echo '1 取得字符串长度'
echo ${#string}             # 结果11  
expr length $string         # 结果11  

echo '2 字符串所在位置'
expr index $string 'abc'    # 字符串对应的下标是从1开始的   

echo '3 字符串截图'
echo ${string:4}            # 从第4位开始截取后面所有字符串    
echo ${string:3:3}          # 从第3位开始截取后面3位    
echo ${string:3:6}          # 从第3位开始截取后面6位    
echo ${string: -4}          # 右边有空格，截取后4位    
echo ${string:(-4)}         # 同上    
expr substr $string 3 3     # 从第3位开始截取后面3位    

str="abcdef"  
expr substr "$str" 1 3      # 从第一个位置开始取3个字符， abc  
expr substr "$str" 2 5      # 从第二个位置开始取5个字符， bcdef   
expr substr "$str" 4 5      # 从第四个位置开始取5个字符， def  

echo ${str:2}               # 从第二个位置开始提取字符串， bcdef  
echo ${str:2:3}             # 从第二个位置开始提取3个字符, bcd  
echo ${str:(-6):5}          # 从倒数第二个位置向左提取字符串, abcde  
echo ${str:(-4):3}          # 从倒数第二个位置向左提取6个字符, cde  

echo '5 匹配显示内容'
expr match $string '\([a-c]*[0-9]*\)' 
expr $string : '\([a-c]*[0-9]\)'      
expr $string : '.*\([0-9][0-9][0-9]\)'  # 显示括号中匹配的内容    

echo '6 截取不匹配的内容'
string='abc12342341'
echo ${string#a*3}     # 从$string左边开始，去掉最短匹配子串    
echo ${string#c*3}     # 这样什么也没有匹配到    
echo ${string#*c1*3}   # 从$string左边开始，去掉最短匹配子串    
echo ${string##a*3}    # 从$string左边开始，去掉最长匹配子串    
echo ${string%3*1}     # 从$string右边开始，去掉最短匹配子串    
echo ${string%%3*1}    # 从$string右边开始，去掉最长匹配子串    

str="abbc,def,ghi,abcjkl"  
echo ${str#a*c}     # 输出,def,ghi,abcjkl  一个井号(#) 表示从左边截取掉最短的匹配 (这里把abbc字串去掉）  
echo ${str##a*c}    # 输出jkl，             两个井号(##) 表示从左边截取掉最长的匹配 (这里把abbc,def,ghi,abc字串去掉)  
echo ${str#"a*c"}   # 输出abbc,def,ghi,abcjkl 因为str中没有"a*c"子串  
echo ${str##"a*c"}  # 输出abbc,def,ghi,abcjkl 同理  
echo ${str#*a*c*}   # 空  
echo ${str##*a*c*}  # 空  
echo ${str#d*f}     # 输出abbc,def,ghi,abcjkl,   
echo ${str#*d*f}    # 输出,ghi,abcjkl     
  
echo ${str%a*l}     # abbc,def,ghi  一个百分号(%)表示从右边截取最短的匹配   
echo ${str%%b*l}    # a 两个百分号表示(%%)表示从右边截取最长的匹配  
echo ${str%a*c}     # abbc,def,ghi,abcjkl    

echo '7 匹配并且替换'
echo ${string/23/bb}   # abc1bb42341  替换一次    
echo ${string//23/bb}  # abc1bb4bb41  双斜杠替换所有匹配    
echo ${string/#abc/bb} # bb12342341   #以什么开头来匹配   
echo ${string/%41/bb}  # abc123423bb  %以什么结尾来匹配

str="apple, tree, apple tree"  
echo ${str/apple/APPLE}   # 替换第一次出现的apple  
echo ${str//apple/APPLE}  # 替换所有apple  
  
echo ${str/#apple/APPLE}  # 如果字符串str以apple开头，则用APPLE替换它  
echo ${str/%apple/APPLE}  # 如果字符串str以apple结尾，则用APPLE替换它  


echo '8 字符串比较'
[[ "a.txt" == a* ]]        # 逻辑真 (pattern matching)  
[[ "a.txt" =~ .*\.txt ]]   # 逻辑真 (regex matching)  
[[ "abc" == "abc" ]]       # 逻辑真 (string comparision)   
[[ "11" < "2" ]]           # 逻辑真 (string comparision), 按ascii值比较  

echo '9 字符串链接'
s1="hello"  
s2="world"  
echo ${s1}${s2}   # 当然这样写 $s1$s2 也行，但最好加上大括号  

echo '10 字符串删除'
# $ test='c:/windows/boot.ini'  
# $ echo ${test#/}  
# c:/windows/boot.ini  
# $ echo ${test#*/}  
# windows/boot.ini  
# $ echo ${test##*/}  
# boot.ini  
  
# $ echo ${test%/*} 
# c:/windows 
# $ echo ${test%%/*} 
 
# ${变量名#substring正则表达式}从字符串开头开始配备substring,删除匹配上的表达式。 
# ${变量名%substring正则表达式}从字符串结尾开始配备substring,删除匹配上的表达式。 
# 注意：${test##*/},${test%/*} 分别是得到文件名，或者目录地址最简单方法。  
