# filter  out those with content-size 666
#   ./script example.com -fs 666
# keep only status_code = 200
#   ./script example.com -mc 200
ffuf ${@:2} -H "Host: FUZZ.$1" -u "http://$1" -w $PROBER_ENV/lists/seclists/SecLists-master/Discovery/DNS/subdomains-top1million-110000.txt
