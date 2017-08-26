#!/bin/bash

nparameter=$#
user=$1

function check_parameter(){
	if (( $nparameter != 1 ))
	then
		echo "Error of parameter"
		exit
#		?=1
	fi
}


function rm_user(){

	pdbedit -L | grep -E "\b$user\b" > /dev/null
	if (( $? == 1))
	then
		echo "Error - User not Found"
		exit
	fi

	cat /etc/passwd | cut -f1 -d: | grep -E "$user" >/dev/null
	if (( $? == 1 ))
	then
		useradd -m $user &> /dev/null
	fi

}


function rm_user(){
	smbpasswd -x $user &> /dev/null
}

check_parameter
check_user
rm_user
echo "OK"