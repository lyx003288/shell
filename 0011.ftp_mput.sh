#!/bin/bash

# ########################################################################################
# ftp 上传文件
# ########################################################################################

function ftp_mput()
{
echo "
open '127.0.0.1' 22 
user ftp_user  ftp_passwd 
prompt                         
binary
mput filename 
close                          
bye                            
"| ftp -v -n | sed 's/^/>/g'
}
