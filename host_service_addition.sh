#!/bin/bash


###################################################################
#    Script to add nagios host or service to specified file                  
#																
#    By Ethan Drower
#    Depaul University
#    Information Services
#
#
#
#    NOTES
#    v3,  Added Service addition functionality
#	
#
#################################################################

while : #loop endlessly
do

		echo 'Welcome to the host addition script! ctrl-c to exit'
		echo 'WARNING: to view all output set terminal row height = 35'
		echo ' '
		echo ' 1 to add a host, 2 to add a service '
		
		read input
		
	case $input in
		
		
	1)
		
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

		
		# ask to create file if it doesn't exist and add the new entry

			if [ ! -f $FILE ] ; then
				echo 'File does not exist, create it?(y or n)'
				read INPUT
			else
			
				sed -i "$ a\\$HOSTDEF" $FILE      #append new host to specified file
				continue
			fi		

			if [ $INPUT == 'y' ] ; then
				echo 'creating file....COMPLETE!'
				echo ' ' >> $FILE
		
				sed -i "$ a\\$HOSTDEF" $FILE      #append new host to specified file
			else
				echo "aborting...."
			fi




	;;



	2)

		### Section 2 will incorporate a function that adds services


		#	
		#	
		#	check file to see if service description already exists
		#		do you want to edit this service or create a new one, replace service
		#		if edit, substitute line by line with what they want
		#
		#    	for finding the string?
		#		grep -F "$cnty" wheatvrice.csv >> wr_imp.csv
		#		
		#   	sed delete a host entry
		#		sed '/firstpart/,/endbracket/d' file.txt

			#for creating new service
		
		echo "Enter File Name"
		read FILENAME
		
		
		echo "Enter the name"
		read SERVICE_NAME

		
		#possible check if ^^^^^ exists?
		
		if grep -Fxq "$SERVICE_NAME" $FILENAME ;then
			# code if found
			echo "Found duplicate service name, continuing..."
				
		fi
		
		
		
		echo "Enter the parent service class i.e. Use value"
		read SERVICE_USE
		
		echo "Enter IP address"
		read SERVICE_IP
		
		
		#echo 'Enter host_name value, s to skip'
		#read input
		
		
		
		
		SERVICEDEF1="define service {
					service_description	$SERVICE_NAME
					use 		    	$SERVICE_USE
					address			$SERVICE_IP
		}"

		
				#switch 2
		SERVICEDEF2="define service {
					service_description	$SERVICE_NAME
					use 		    	$SERVICE_USE
					address			$SERVICE_IP 
					host_name		$SERVICE_HOSTNAME
					
		}"
		

		SERVICEDEF3="define service {
					service_description	$SERVICE_NAME
					use 		    	$SERVICE_USE
					address			$SERVICE_IP 
					host_name		$SERVICE_HOSTNAME
					host_group		$SERVICE_HOSTGROUP
					
		}"
		
		
		#switch 4
		SERVICEDEF4="define service {
					service_description	$SERVICE_NAME
					use 		    	$SERVICE_USE
					host_name		$SERVICE_HOSTNAME
					host_group		$SERVICE_HOSTGROUP
					servicegroups		$SERVICE_GROUPS
		}"

		
		echo "Pick your template..."
		
		echo -e "1: 	 $SERVICEDEF1 \n"
		
		echo -e "2:	 $SERVICEDEF2 \n"

		echo -e "3:	 $SERVICEDEF3 \n"
			
		echo -e "4:	 $SERVICEDEF4 \n"
		
		
		
		
		read myswitch
		
		case $myswitch in
			1 )
			
			#nothing else to add
			
			
				SERVICEDEF="define service {\\
						service_description	$SERVICE_NAME\\
						use 		    	$SERVICE_USE\\
						address			$SERVICE_IP \\
				\}\\" 
			;;
		
			
			2 )
				
				echo "Etner the hostname: "
				read SERVICE_HOSTNAME
				
				
				SERVICEDEF="define service {\\
						service_description	$SERVICE_NAME\\
						use 		    	$SERVICE_USE\\
						address			$SERVICE_IP \\
						host_name		$SERVICE_HOSTNAME\\
					
				\}\\"
			;;
			
		
		
			3 )
				echo "Etner the hostname: "
				read SERVICE_HOSTNAME
				
				
				echo "Enter the host group: "
				read SERVICE_HOSTGROUP
				
			
			
				SERVICEDEF="define service {\\
					service_description	$SERVICE_NAME\\
					use 		    	$SERVICE_USE\\
					address			$SERVICE_IP \\
					host_name		$SERVICE_HOSTNAME\\
					host_group		$SERVICE_HOSTGROUP\\
					
				\}\\"
			;;
			
			
			
			4 )
				echo "Etner the hostname: "
				read SERVICE_HOSTNAME
				
				
				echo "Enter the host group: "
				read SERVICE_HOSTGROUP
				
				
				echo "Enter the service groups"
				
				read SERVICE_GROUPS
				
				
				
				
				SERVICEDEF="define service {\\
					service_description	$SERVICE_NAME\\
					use 		    	$SERVICE_USE\\
					address			$SERVICE_IP \\
					host_name		$SERVICE_HOSTNAME\\
					host_group		$SERVICE_HOSTGROUP\\
					servicegroups		$SERVICE_GROUPS\\
				\}\\ "
			
			;;
			
		esac	

		
		# ask to create file if it doesn't exist and add the new entry

			if [ ! -f $FILENAME ] ; then
				echo 'File does not exist, create it?(y or n)'
				read INPUT
			else
				echo "adding to file..."	
				sed -i "$ a\\$SERVICEDEF" $FILENAME      #append new host to specified file
				continue
			fi		

			if [ $INPUT == 'y' ] ; then
				echo 'creating file....COMPLETE!'
				echo ' ' >> $FILENAME
		
				sed -i "$ a\\$SERVICEDEF" $FILENAME      #append new host to specified file
			else
				echo "aborting...."
			fi

	;;
	
	esac

done











