#!/bin/bash

set -e

RES_FILE=$(dirname $0)/request_100.log

: > $RES_FILE

for i in {1..100}; do
  curl -X GET http://localhost:3099/users -w "%{http_code} %{time_starttransfer}\n" -o /dev/null -s >> $RES_FILE
  #curl -X GET http://localhost:3099/users -w "%{http_code} %{time_starttransfer}\n" -o /dev/null -s | tee -a $RES_FILE
  case $i in
    1)
      echo -ne '#                     ( 1%)\r';;
    10)
      echo -ne '###                   (10%)\r';;
    20)
      echo -ne '#####                 (20%)\r';;
    30)
      echo -ne '#######               (30%)\r';;
    40)
      echo -ne '#########             (40%)\r';;
    50)
      echo -ne '###########           (50%)\r';;
    60)
      echo -ne '#############         (60%)\r';;
    70)
      echo -ne '###############       (70%)\r';;
    80)
      echo -ne '#################     (80%)\r';;
    90)
      echo -ne '###################   (90%)\r';;
    100)
      echo -ne '##################### (100%)\r';;
  esac
done
echo -ne '\n'

echo '---------------------------------------------------------'
echo 'Number of valid responses'
cat $RES_FILE | wc -l | xargs
echo 'Average response time'
awk '$1 = 200 { sum += $2 } END { print sum/NR }' $RES_FILE
