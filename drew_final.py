import csv


#############################################
# 2013 Written by Ethan Drower
#   
# Script to parse phone records
# Meant for reconcilliation of accounts
# Phone Migration Project
#   
#
# Input files:
#
#voip_service.txt
#LoopnPhones_forBAT.txt

#Output Files:
#
#DN_Numbers.out
#Model7692.out
#Model6921.out
#ModelAssorted.out
#NortelTN.out
#MultipleDN.out


#globals
dn_input_array = []
mac_dictionary = {}

def Initialize_Logs():
#Header strings for the phone model output files below 
    str6921 = 'MAC ADDRESS,DESCRIPTION,DIRECTORY NUMBER  1,LINE CSS  1,ASCII ALERTING NAME  1,ALERTING NAME  1,ASCII DISPLAY  1,DISPLAY  1,LINE TEXT LABEL  1,ASCII LINE TEXT LABEL  1 \n'
    str7962 = 'MAC ADDRESS,DESCRIPTION,DIRECTORY NUMBER  1,LINE CSS  1,ASCII ALERTING NAME  1,ALERTING NAME  1,ASCII DISPLAY  1,DISPLAY  1,LINE TEXT LABEL  1,ASCII LINE TEXT LABEL  1,DIRECTORY NUMBER 2,LINE CSS 2,ASCII ALERTING NAME 2,ALERTING NAME 2,ASCII DISPLAY 2,DISPLAY 2,LINE TEXT LABEL 2,ASCII LINE TEXT LABEL 2,DIRECTORY NUMBER 3,LINE CSS 3,ASCII ALERTING NAME 3,ALERTING NAME 3,ASCII DISPLAY 3,DISPLAY 3,LINE TEXT LABEL 3,ASCII LINE TEXT LABEL 3,DIRECTORY NUMBER 4,LINE CSS 4,ASCII ALERTING NAME 4,ALERTING NAME 4,ASCII DISPLAY 4,DISPLAY 4,LINE TEXT LABEL 4,ASCII LINE TEXT LABEL 4,DIRECTORY NUMBER 5,LINE CSS 5,ASCII ALERTING NAME 5,ALERTING NAME 5,ASCII DISPLAY 5,DISPLAY 5,LINE TEXT LABEL 5,ASCII LINE TEXT LABEL 5,DIRECTORY NUMBER 6,LINE CSS 6,ASCII ALERTING NAME 6,ALERTING NAME 6,ASCII DISPLAY 6,DISPLAY 6,LINE TEXT LABEL 6,ASCII LINE TEXT LABEL 6 \n'
    strAssorted = ''
    strMultipleDN = ''
    strDNNumbers = ''
    strNortelTn = ''

    file = open('DN_Numbers.out', 'w')
    file.write(strDNNumbers)
    file.close()

    file = open('ModelAssorted.out', 'w')
    file.write(strAssorted)
    file.close()

    file = open('NortelTN.out', 'w')
    file.write(strNortelTn)
    file.close()

    file = open('MultipleDn.out', 'w')
    file.write(str6921)
    file.close()
    
    file = open('Model6921.out', 'w')
    file.write(str6921)
    file.close()

    file = open('Model7962.out', 'w')
    file.write(str7962)
    file.close()


def build_data_structs():

    with open('voip_service.txt', 'r') as csvfile:
        parser = csv.reader(csvfile, delimiter=',')
        for row in parser:
            dn_input_array.append(row[2])
            mac_dictionary[row[2]] = row[1]

    print('input array is : ')
    print (dn_input_array)
    
#############################################################################

def Parse_By_DN(dn_input):
    mac = str( mac_dictionary[dn_input])
    Write_Mac_To_Log(mac)
    place_holder_row = []

    #dn_input = '26923'  # this will be an index of dn_input_array eventually
    dn_input_counter = 0


    #this loops through main batch of phones and searches for the D/N

    with open('LoopNortelPhones_forBAT.txt') as csvfile:
        parser = csv.reader(csvfile, delimiter=',')

        #now we need to loop through each line

        for row in parser:

           # Model_Func(dn_input, row)
           # Write_To_DN_OUT(dn_input)

            for item in row:
                if (item == dn_input):
                    #print (item)
                   
                    place_holder_row.append(row)
                    #Model_Func(dn_input, row)
                    
                    dn_input_counter += 1
        csvfile.close()
        print ('Parsed LoopNortelPhones file for dn # ' + dn_input + ' found ' + str(dn_input_counter) + ' instances of the DN number. \n')
        
        if (len(place_holder_row) > 0 ):
            
            if (len(place_holder_row) > 1):
                
                
                #put into multiple dn file
                    #end
                print ('Multiple rows that match dn# '+ dn_input )
                mac = str( mac_dictionary[dn_input])
                
                
                row_as_string = ''

                for row in place_holder_row:
                    
                    print('placeholder row is : ')
                    print(row)
                    for item in range(0, len(row)):
                        
                        if item == 4:    
                            row[item] = '"'+ row[item] + '"'
                            
                        row_as_string += ',' + row[item]     
                        mac_and_row = mac + row_as_string + '\n'
                       # print(' mac and row is: ' + mac_and_row)
                                          
                    
                    file = open('MultipleDN.out', 'a')
                    file.write( mac_and_row)
                    file.close()
                    print('just wrote ' + mac_and_row)
                    mac_and_row = ''
                    row_as_string = ''
            else:
                    
                for row in place_holder_row:
                    Model_Func(dn_input, row)
                    Write_To_NortelTN(dn_input, row)
            
            
        else:
            print ('no dn found ERROR!')
            Write_To_DN_ERROR(dn_input)
            
            
            #Handle_DN_Counter(dn_input_counter, dn_input)
           

            
        # Uncomment this if you want unknown DNs (not found in big csv) to be added to log files 
        # Handle_DN_Counter(dn_input_counter, dn_input)
        

        
#################End of Function####################################


def Write_Mac_To_Log(mac):
    file = open('MacAddresses.out', 'a')
    file.write(mac + '\n')
    file.close()

def Write_To_DN_ERROR(dn_number):
    print('write to dn error is called....')
    
    file = open('DN_ERROR.out', 'a')
    file.write(dn_number + '\n')
    file.close()   

def Write_To_DN_OUT(dn_number):
    file = open('DN_Numbers.out', 'a')
    file.write(dn_number + '\n')
    file.close()
    print ('Writing parsed DN # to DN_Numbers.out file...Complete!')

def Write_To_NortelTN(dn_input, row):
    output = row[0] + ',' + row[1] + '\n'
    #print ('output is ' + output)

    #write to output file
    file = open('NortelTN.out', 'a')
    file.write(output)
    file.close()  


#check voip model and do conditional
                    
def Model_Func(dn_number, whole_row):
    print ('Checking phone model of DN record...')
    
    output_file = ''
   # print('row given to model func is ')
    #print (whole_row)
    Write_To_DN_OUT(dn_number)
    
    #have to get the model in question, by dn number? how?
    model = whole_row[2]
    if (model == '7962'):
        output_file = 'Model7692.out'
    elif model == '6921':
        output_file = 'Model6921.out'
    else:
        output_file = 'ModelAssorted.out'

    model_file = open(output_file, 'a')
    print('Model is ' + model + '! Writing to Model'+model+'.out file...Complete')
    
    #construct string here
    #remove model from row array
    #del whole_row[0:3]
    model_string = str(mac_dictionary[dn_number])

    
    for item in range(3,len(whole_row)):
        if(item == 4):
            whole_row[item] = '"' + whole_row[item] + '"' 
            model_string += whole_row[item]
        else:
            model_string +=  ',' + whole_row[item]
    
    model_string =  model_string + '\n'    
    #model_string = str(mac_dictionary[dn_number])+ ' ' + str(whole_row) + '\n'
    model_file.write(model_string)
    model_file.close()
#########end of function###############


# 'Main' Method
build_data_structs()
Initialize_Logs()

for dn_number in dn_input_array:
    Parse_By_DN(dn_number);
    #Write_To_DN_OUT(dn_number)

#print( dn_input_array)




