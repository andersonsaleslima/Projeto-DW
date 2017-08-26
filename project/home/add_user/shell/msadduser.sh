#!/bin/bash

nparameter=$#
user=$1
password=$2

function check_parameter(){
	if (( $nparameter !=2 ))
	then
		#echo "{'status': 'Error of parameter'}"
		echo "Error of parameter"
		exit
#		?=1
	fi
}

function add_user(){
	smbpasswd -a $user -s << FIM
$password
$password
FIM
}

function check_user(){

	cat /etc/passwd | cut -f1 -d: | grep -E "$user" > /dev/null
	result=$?

	if (( $result == 1 ))
	then
		crypted=$(echo $password | mkpasswd -s -H md5)
		useradd -m $user -p $crypted &> /dev/null
	fi

	pdbedit -L | grep -E "\b$user\b" &> /dev/null
	if (( $? == 1))
	then
		add_user &> /dev/null
	else
		#echo "{'status': 'Error - User exist'}"
		echo "Error - User exist"
		exit
	fi

}

check_parameter
check_user
#echo "{'status': 'OK'}"
echo "OK"
