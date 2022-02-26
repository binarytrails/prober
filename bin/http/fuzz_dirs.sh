# PROBER_ENV=... ./fuzz_dirs.sh example.com
# show only status_code=200:
#   ./script example.com -mc 200
ffuf ${@:2} -u "http://$1/FUZZ" -w $PROBER_ENV/lists/seclists/SecLists-master/Discovery/Web-Content/raft-small-words.txt
