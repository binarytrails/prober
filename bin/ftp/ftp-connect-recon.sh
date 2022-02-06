echo "touch test && ./ftp-connect-recon.sh <ip> <user> <password> <logfile>"
touch test.txt
echo "open $1 21
user $2 $3
status
put test.txt
delete test.txt
bye " | ftp -v -n >> $4
echo >> $4
