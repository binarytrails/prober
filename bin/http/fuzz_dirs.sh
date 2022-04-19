# PROBER_ENV=... ./fuzz_dirs.sh example.com
ffuf -u "http://$1/FUZZ" -w $PROBER_ENV/lists/seclists/SecLists-master/Discovery/Web-Content/raft-large-directories.txt
