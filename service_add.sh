
### Section 2 will incorporate a function that adds services


#	define service {
#						service_description			C
#						use
#						check_command
#						host_name or host_group
#						notification period
#						servicegroups 
#	}
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
	
	
	
	#if [ $INPUT == 's' ] ; then
	#		echo 'skipping...' 
			#append new host to specified file
	#	else
	#		ADDED_STRING=$input;
	#		ADDED_STRING="host_name			$input\\"
	#		SERVICE_HOSTNAME=$input
	#fi
	
	
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
			}" 
		;;
	
		
		2 )
			
			echo "Etner the hostname: "
			read SERVICE_HOSTNAME
			
			
			SERVICEDEF3="define service {\\
					service_description	$SERVICE_NAME\\
					use 		    	$SERVICE_USE\\
					address			$SERVICE_IP \\
					host_name		$SERVICE_HOSTNAME\\
				
			}"
		;;
		
	
	
		3 )
			echo "Etner the hostname: "
			read SERVICE_HOSTNAME
			
			
			echo "Enter the host group: "
			read SERVICE_HOSTGROUP
			
		
		
			SERVICEDEF="define service {\\
				service_description	$SERVICE_NAME\\
				use 		    	$SERVICE_USE\\
				address				$SERVICE_IP \\
				host_name			$SERVICE_HOSTNAME\\
				host_group			$SERVICE_HOSTGROUP\\
				
			}"
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
				address				$SERVICE_IP \\
				host_name			$SERVICE_HOSTNAME\\
				host_group			$SERVICE_HOSTGROUP\\
				servicegroups		$SERVICE_GROUPS\\
			}"
		
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

	
