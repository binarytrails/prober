echo """
 ██▓███   ██▀███   ▒█████   ▄▄▄▄   ▓█████  ██▀███  
▓██░  ██▒▓██ ▒ ██▒▒██▒  ██▒▓█████▄ ▓█   ▀ ▓██ ▒ ██▒
▓██░ ██▓▒▓██ ░▄█ ▒▒██░  ██▒▒██▒ ▄██▒███   ▓██ ░▄█ ▒
▒██▄█▓▒ ▒▒██▀▀█▄  ▒██   ██░▒██░█▀  ▒▓█  ▄ ▒██▀▀█▄  
▒██▒ ░  ░░██▓ ▒██▒░ ████▓▒░░▓█  ▀█▓░▒████▒░██▓ ▒██▒
▒▓▒░ ░  ░░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░▒▓███▀▒░░ ▒░ ░░ ▒▓ ░▒▓░
░▒ ░       ░▒ ░ ▒░  ░ ▒ ▒░ ▒░▒   ░  ░ ░  ░  ░▒ ░ ▒░
░░         ░░   ░ ░ ░ ░ ▒   ░    ░    ░     ░░   ░ 
            ░         ░ ░   ░         ░  ░   ░     

    - Pentest journey by Vsevolod (Seva) Ivanov <seva@binarytrails.net>
    
        By default, gets only [light] & asks confirmation for rest. 
        Run & control with 'AVERAGE=y HEAVY=n ./prober.sh'
""";

LIGHT="y";
#AVERAGE="";
#HEAVY="";

# docs
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone docs? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    git clone https://github.com/binarytrails/notes.git docs/notes;
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git docs/payloadsallthethings;
    git clone https://github.com/GTFOBins/GTFOBins.github.io.git docs/gtfo-bins;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone docs/hacktricks? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    git clone https://github.com/carlospolop/hacktricks.git docs/hacktricks;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone docs/ired.team? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    git clone https://github.com/mantvydasb/RedTeam-Tactics-and-Techniques.git docs/ired-team;
      ln -fs ./ired-team/offensive-security-experiments/offensive-security-cheetsheets/README.md docs/cheatsheets-ired-team.md;
fi

# bin
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone bin? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite bin/peass;
        ln -fs peass/linPEAS/linpeas.sh bin/linpeas.sh;
        ln -fs ../peass/winPEAS/winPEASbat/winPEAS.bat bin/win/winpeas.bat;
    git clone https://github.com/SecureAuthCorp/impacket.git bin/impacket;
    git clone https://github.com/binarytrails/yaptest.git bin/yaptest;
    git clone https://github.com/rezasp/joomscan.git bin/joomscan;
    echo "go get github.com/tomnomnom/waybackurls" && go get github.com/tomnomnom/waybackurls;
      ln -fs ~/go/bin/waybackurls bin/waybackurls;
fi

# lists
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone lists? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    git clone https://github.com/xajkep/wordlists lists/wordlists;
fi
if [[ "$HEAVY" != "y" && "$HEAVY" != "n" ]]; then
    read -p "Do you want to clone seclists? [heavy] (y/n)? " HEAVY;
fi
if [ "$HEAVY" = "y" ]; then
    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
      && unzip SecList.zip -d lists/seclists \
      && rm -f SecList.zip;
fi
