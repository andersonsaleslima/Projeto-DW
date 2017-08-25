#!/bin/bash

senha=$(echo $2 | mkpasswd -s -H md5)
useradd -m $1 -p $senha

smbpasswd -a $1 <<FIM
$2
$2
FIM
