#!/bin/bash


###################################################################
#    Script to add nagios host to specified file                  
#																
#    By Ethan Drower
#    Depaul University
#    Information Services
#
#
#
#    NOTES
#    V2, loops for repeated adds, cleaned up logic, stable.
# 
#################################################################


while : #loop endlessly
do

echo 'Welcome to the host addition script! ctrl-c to exit'
echo 'Please enter the hostname: ' 

read HOSTNAME
ALIAS=$HOSTNAME

echo 'Enter the host ip: '
read IP

echo 'Enter template to use: '
read USE


echo 'Single contacts (1) or Contact group (2)?: '
read input

	if [[ $input == 1 ]] ; then
		CONTACT_TYPE='contacts'
	else
		CONTACT_TYPE='contact_groups'
	fi




echo 'Enter contacts or contact groups (separated by comma): '
read CONTACTS


#create host entry from user inputs
HOSTDEF="define host {\\
			host_name		$HOSTNAME\\
			alias 		    	$ALIAS\\
			address			$IP \\
			use			$USE\\
			$CONTACT_TYPE		$CONTACTS\\
}"





echo 'Enter the file the host will be added to: '
read FILE

	
#ask to create file if it doesn't exist and add the new entry

	if [ ! -f $FILE ] ; then
		echo 'File does not exist, create it?(y or n)'
		read INPUT
	else
		
		sed -i "$ a\\$HOSTDEF" $FILE      #append new host to specififed file
		continue
	fi		

	if [ $INPUT == 'y' ] ; then
		echo 'creating file....COMPLETE!'
		echo ' ' >> $FILE
	
		sed -i "$ a\\$HOSTDEF" $FILE      #append new host to specififed file
	else
		echo "aborting...."
	fi

done




