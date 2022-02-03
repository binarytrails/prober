# ./fuzz_dirs.sh example.com
# add -fs to omit few per resp length
ffuf -u "http://$1/FUZZ" -w ../../lists/seclists/SecLists-master/Discovery/Web-Content/raft-small-words.txt
