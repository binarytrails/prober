echo "touch test && ./ftp-connect-recon.sh <ip> <user> <password> <logfile>"
echo "open $1 21
user $2 $3
status
put test
delete test
bye " | ftp -v -n >> $4
echo >> $4
