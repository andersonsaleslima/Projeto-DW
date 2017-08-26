#!/bin/bash


amount=0
i=0
j=0

amount_sharing=$(grep -nE "\[.*\]" /etc/samba/smb.conf | wc -l)


for (( i=1 ; i<=amount_sharing; i++ ))
do
	j=$(($i+1))
	line_init=$(grep -nE "\[.*\]" /etc/samba/smb.conf | sed -n "$i p" | cut -f1 -d: )

	if (( $i < $amount_sharing ))
	then
		line_init_next=$(grep -nE "\[.*\]" /etc/samba/smb.conf | sed -n "$j p" | cut -f1 -d: )
	
		sharing=$(sed -n "$line_init p" /etc/samba/smb.conf | cut -f2 -d'[' | sed "s/]//" )
	
		k=$line_init
		while [ $k -lt $line_init_next ]
		do
			k=$(($k+1))
	
			if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*writeable" &> /dev/null
			then
				permission=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
			fi
	
			if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*path" &> /dev/null
			then
				path=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
			fi
	
			if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*valid users" &> /dev/null
			then
				user=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
			fi
		done
		echo "$sharing:$permission:$path:$user"
	else
		amount_line=$(cat /etc/samba/smb.conf | wc -l)

		sharing=$(sed -n "$line_init p" /etc/samba/smb.conf | cut -f2 -d'[' | sed "s/]//" )	
		k=$line_init

		while [ $k -le $amount_line ]
		do
				k=$(($k+1))
	
				if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*writeable" &> /dev/null
				then
					permission=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
				fi
	
				if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*path" &> /dev/null
				then
					path=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
				fi
	
				if sed -n "$k p" /etc/samba/smb.conf | grep -E "^[ ]*valid users" &> /dev/null
				then
					user=$(sed -n "$k p" /etc/samba/smb.conf | cut -f2 -d'=')
				fi
		done
		echo "$sharing:$permission:$path:$user"
	fi
done

