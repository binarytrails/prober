# ./dirbuster http://host/
gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt -t 100 -e -u $@ 
