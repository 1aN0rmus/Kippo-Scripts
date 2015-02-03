#!/bin/bash

echo '---Stats---'
echo 'Number of login attempts:'
pcregrep -r --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| wc -l
echo 'Successful login attempts:'
pcregrep -r --include=kippo.log 'succeeded' . | wc -l
echo 'Failed login attempts:'
pcregrep -r --include=kippo.log 'login\sattempt.+failed' . | wc -l
echo 'Number of Unique Usernames:'
pcregrep -r --include=kippo.log -o1 'login\sattempt\s\[(.+)\/(.+)\]' .| sort -u | wc -l
echo 'Number of Unique Passwords:'
pcregrep -r --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| sort -u | wc -l
echo 'Top 10 Unique Usernames'
pcregrep -hr --include=kippo.log -o1 'login\sattempt\s\[(.+)\/(.+)\]' .| sort | uniq -c | sort -rn | head
echo 'Top 10 Passwords'
pcregrep -hr --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| sort | uniq -c | sort -rn | head
echo 'Top 10 Passwords 8 or more characters:'
pcregrep -hr --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| grep -P ".{8,255}" | sort | uniq -c | sort -rn | head
echo 'Top 10 Passwords 10 or more characters:'
pcregrep -hr --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| grep -P ".{10,255}" | sort | uniq -c | sort -rn | head
echo 'Top 10 Attackers:'
pcregrep -hr --include=kippo.log -o1 'New\sconnection\:\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\:' . | sort | uniq -c | sort -rn | head


echo 'output'
pcregrep -rh --include=kippo.log -o1 'New\sconnection\:\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\:' . | sort | uniq -c | sort -rn > attackerip.out
pcregrep -hr --include=kippo.log -o2 'login\sattempt\s\[(.+)\/(.+)\]' .| sort | uniq > wordlist.out
