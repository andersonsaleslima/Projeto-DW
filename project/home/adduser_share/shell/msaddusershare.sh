#!/bin/bash

nparameter=$#
name_of_share=$1
user=$2
password=$3

function check_parameter(){
	if (( $nparameter !=2 ))
	then
		echo "Error of parameter"
		exit
#		?=1
	fi
}

function check_existence(){
	grep -E "[ ]*\[\b$name_of_share\b\]" /etc/samba/smb.conf &> /dev/null
	if (( $? == 1 ))
	then
		echo "Error - Sharing not found"
#		?=1
		exit
	fi
}

function check_user(){

	cat /etc/passwd | cut -f1 -d: | grep -E "$user" >/dev/null
	if (( #? == 1 ))
	then
		crypted=$(echo $password | mkpasswd -s -H md5)
		useradd -m $1 -p $crypted
	fi
	pdbedit -L | grep -E "\b$user\b" > /dev/null
	if (( $? == 1))
	then
		smbpasswd -a $user -s << FIM
$password
$password
FIM
	fi

}

function set_user(){
	line_init=$(grep -nE "^[ ]*\[\b$name_of_share\b\]" /etc/samba/smb.conf | cut -f1 -d:)
	number_init=$(grep -nE "^[ ]*\[.*\]" /etc/samba/smb.conf | cut -f1 -d: | grep -n "^\b$line_init\b" | cut -f1 -d: )
	number_next=$(($number_init+1))
	line_end=$(grep -nE "^[ ]*\[.*\]" /etc/samba/smb.conf | cut -f1 -d: | grep -nv "^\b$line_init\b" | grep "^\b$number_next\b" | cut -f2 -d: )
	line_end=$(($line_end-1))
	if (( $line_end <= 0 ))
	then
		line_end=$(wc -l /etc/samba/smb.conf | cut -f1 -d' ')
	fi

	sed -n "$line_init,$line_end p" /etc/samba/smb.conf | grep -n "^[ ]*valid users" &> /dev/null
	if (( $? == 1 ))
	then
		sed -i "$line_end a valid users = $user" /etc/samba/smb.conf > /dev/null
	else
		nline_of_user=$(sed -n "$line_init,$line_end p" /etc/samba/smb.conf | grep -n "^[ ]*valid users" | cut -f1 -d:)
		nline_of_user=$(($line_init + $nline_of_user - 1 ))
		line_of_user=$(sed -n "$nline_of_user p" /etc/samba/smb.conf)
		line_of_user="$line_of_user $user"
		line_end=$(($line_end-1))
		sed -i "$nline_of_user d" /etc/samba/smb.conf &> /dev/null
		sed -i "$line_end a $line_of_user" /etc/samba/smb.conf &> /dev/null
	fi

}

check_parameter
check_existence
check_user
set_user
echo "OK"
