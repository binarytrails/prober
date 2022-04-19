# PROBER_ENV=... ./fuzz_files.sh example.com
ffuf -u "http://$1/FUZZ" -w $PROBER_ENV/lists/seclists/SecLists-master/Discovery/Web-Content/raft-large-files.txt
