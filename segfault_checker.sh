#!/bin/sh

test="$(tail -100 /var/log/messages | grep segfault)"

SUBJECT="DRMS02 Segfault"
EMAIL="oss@depaul.edu"
MESSAGE="/tmp/segfaultmessage.txt"

echo "Segfault has been detected on drms02" > $MESSAGE

if [ -n $test ]
then

#echo 'hello'


/bin/mail -s "$SUBJECT" "$EMAIL"  < $MESSAGE
fi
