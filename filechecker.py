
import sys

print sys.argv[1]

print ('Please enter the hostname to find: ')
hostname = raw_input()


myfile = sys.argv[1]

with open(myfile, 'rU') as f:
   

    for row in f:
        for item in row:
            if (item == hostname):
		print ('Hostname ' + hostname + ' found in ' + myfile)

f.close()
