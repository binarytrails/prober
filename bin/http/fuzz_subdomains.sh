ffuf -H "Host: FUZZ.$1" -u "http://$1" -w $PROBER_ENV/lists/seclists/SecLists-master/Discovery/DNS/subdomains-top1million-110000.txt
