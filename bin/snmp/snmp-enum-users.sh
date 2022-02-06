# ./script.sh <ip>
snmpwalk -c public -v1 $1 1.3.6.1.4.1.77.1.2.25
