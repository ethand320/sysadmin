#!/usr/bin/python


#Script to check licnese plate against chicago's towing database
#will add user input eventually. and email support.

import sys
import smtplib
import re
import urllib
import urllib2
import time
import logging
from subprocess import Popen, PIPE
license = "78731FF"

data = { "{actionForm.plateNumber}" : license }

encoded_data = urllib.urlencode(data)

content = urllib2.urlopen("https://webapps1.cityofchicago.org/vehicleSearch/org/cityofchicago/vs/controller/search/searchPlate.do", encoded_data)




str1 = content.read()
#print str1 
#print str.find("<label>CHEV</label>")
today =  time.strftime("%x")

logging.basicConfig(filename='/var/log/towlog.out',level=logging.DEBUG)

if today in str1:
	print "ethan is screwed"
	logging.debug('ethan is screwed!')
else:
    print "No worky"
    logging.debug('Nothing to report...')

#if "10/05/2013" in str1:
#	print "it worked"




