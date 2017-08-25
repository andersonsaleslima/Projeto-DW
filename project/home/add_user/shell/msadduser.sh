#!/bin/bash

nparameter=$#
user=$1
password=$2

function check_parameter(){
	if (( $nparameter !=2 ))
	then
		echo "Error of parameter"
		exit
#		?=1
	fi
}

function check_user(){

	cat /etc/passwd | cut -f1 -d: | grep -E "$user" > /dev/null
	if (( #? == 1 ))
	then
		crypted=$(echo $password | mkpasswd -s -H md5)
		useradd -m $1 -p $crypted
	else
		echo "Error - User exist"
		exit
	fi

	pdbedit -L | grep -E "\b$user\b" > /dev/null
	if (( $? == 1))
	then
		smbpasswd -a $user -s << FIM
$password
$password
FIM
	else
		echo "Error - User exist"
		exit
	fi

}

check_parameter
check_user
echo "OK"
