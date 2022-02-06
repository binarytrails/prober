#!/bin/bash -x
#
# ███████╗███╗   ███╗██████╗     ██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗
# ██╔════╝████╗ ████║██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║
# ███████╗██╔████╔██║██████╔╝    ██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║
# ╚════██║██║╚██╔╝██║██╔══██╗    ██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║
# ███████║██║ ╚═╝ ██║██████╔╝    ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║
# ╚══════╝╚═╝     ╚═╝╚═════╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝
#
# 	smoll automation by @binarytrails
#
# 	./smb-recon.sh <ip> | tee smb-recon.log

#=======================[enum hostname]========================
enum4linux -n $1
nmblookup -A $1
nmap --script=smb-enum* --script-args=unsafe=1 -T5 $1

#=======================[get version]==========================
echo "command to try: msfconsole; use scanner/smb/smb_version"
smbclient -L \\\\$1
echo ''

#=======================[get shares]===========================
nmap --script smb-enum-shares -p139,445 -T4 -Pn $1
smbclient -L //$1 -N
echo exit | smbclient -L \\\\$1
smbclient -L \\\\$1\\
echo ''

#====================[check null sessions]=====================
smbmap -H $1
rpcclient -U "" -N $1
smbclient //$1/IPC$ -N
echo ''

echo "enter a share name for the next commands: "
read share
smbmap -H  $1 -R $share
smbclient \\\\$1\\$share
echo ''

#==================[connect to username shares]================
echo 'smbclient //$1/$share -U username'

#==================[connect to share anonymously]==============
smbclient \\\\$1\\$share
smbclient //$1/$share

#=======================[extra manual tries]=============================
echo 'smbclient //$1/<share\ name>'
echo 'smbclient //$1/<""share name"">'
echo ''

#=====================[monitoring for smb packets]=============================
echo "to monitor on an interface run: ngrep -i -d tap0 's.?a.?m.?b.?a.*[[:digit:]]'"
