#!/bin/bash

# ########################################################################################
# COMMENTBLOCK 用来注释整段脚本代码。 : 是shell中的空语句。
# ########################################################################################

function test()
{
    echo "function test start"
: << COMMENTBLOCK
   this is test code, you can write any code.
                                author: airy
COMMENTBLOCK

    echo "funciton test run over"
}

test