#!/bin/bash

nparameter=$#
name_of_share=$1
folder=$2
permission=$3
write="no"

function check_init(){
	grep -E "\[\bglobal\b\]" /etc/samba/smb.conf &> /dev/null
	if (( $? == 1 ))
	then
		file=$(cat /etc/samba/smb.conf)
		echo "[global]" > /etc/samba/smb.conf
		echo "WORKGROUP = grupo" >> /etc/samba/smb.conf
		echo "security = user" >> /etc/samba/smb.conf
		cat file >> /etc/samba/smb.conf &> /dev/null
	fi
}

function check_parameter(){

	if (( $nparameter !=  3))
	then
		echo "ERRO - comando incompleto"
		exit
	fi
}

function check_existence(){

	existence=0
	if grep -E "\[\b$name_of_share\b\]" /etc/samba/smb.conf > /dev/null
	then
		existence=1
	fi
}

function check_directory(){

	ls -Rl /publico | grep -E "^d" | grep -E "\b$folder\b" #> /dev/null
	if (( $? == 1 ))
	then
		mkdir /publico/$folder
		chmod -R 777 /publico
	fi
}

function check_permission(){

	if [ $permission != "r" ] && [ $permission != "w" ]
	then
		echo "ERRO - permissão incorreta"
		exit
	else
		case $permission in

			r)
				write="no"
				;;
			w)
				write="yes"
				;;
		esac
		echo $write
	fi
}


function setting(){

	echo $users
	if (( $existence == 0 ))
	then
		sudo echo >> /etc/samba/smb.conf
		sudo echo "[$name_of_share]" >> /etc/samba/smb.conf
		sudo echo "writeable = $write" >> /etc/samba/smb.conf
		sudo echo "path = /publico/$folder" >> /etc/samba/smb.conf
		sudo echo "valid users = " >> /etc/samba/smb.conf
	else
		line_init=$(grep -nE "\[\b$name_of_share\b\]" /etc/samba/smb.conf | cut -f1 -d:)
		echo $init
		number_init=$(grep -nE "\[.*\]" /etc/samba/smb.conf | cut -f1 -d: | grep -n "\b$line_init\b" | cut -f1 -d: )
		number_next=$(($number_init+1))
		line_end=$(grep -nE "\[.*]" /etc/samba/smb.conf | cut -f1 -d: | grep -nv "\b$line_init\b" | grep "\b$number_next\b" | cut -f2 -d: )
		end=$(($end-1))
		if (( $end <= 0 ))
		then
			end=$(wc -l /etc/samba/smb.conf | cut -f1 -d' ')
		fi
		sudo sed -i "$init,$end d" /etc/samba/smb.conf

		sudo echo "[$name_of_share]" >> /etc/samba/smb.conf
		sudo echo "writeable = $write" >> /etc/samba/smb.conf
		sudo echo "path = /publico/$folder" >> /etc/samba/smb.conf
		sudo echo "valid users = " >> /etc/samba/smb.conf
	 fi
}

check_init
check_parameter
check_existence
check_directory
check_permission
setting
