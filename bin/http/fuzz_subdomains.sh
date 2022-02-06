# ./fuzz_subdomains.sh example.com
ffuf -mc 200 -H "Host: FUZZ.$1" -u "http://$1" -w ../../lists/seclists/SecLists-master/Discovery/DNS/subdomains-top1million-110000.txt
