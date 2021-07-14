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

    Pentest framework build around GitHub by binarytrails

    Example: 'AVERAGE=y HEAVY=n ./prober.sh'
    Project source: https://github.com/binarytrails/prober
""";

LIGHT="y";
#AVERAGE="";
#HEAVY="";

# src
mkdir -p src/extra;
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone sploit sources? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    git clone https://github.com/qazbnm456/awesome-cve-poc src/extra/cve-poc;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone more sploit sources? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    git clone https://github.com/zhzyker/exphub src/extra/exphub;
fi

# docs
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone docs? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    wget https://raw.githubusercontent.com/six2dez/OSCP-Human-Guide/master/oscp_human_guide.md -O docs/everything-1.md;
    git clone https://github.com/binarytrails/notes.git docs/notes;
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git docs/payloadsallthethings;
    git clone https://github.com/GTFOBins/GTFOBins.github.io.git docs/gtfo-bins;
    wget https://raw.githubusercontent.com/snoopysecurity/awesome-burp-extensions/master/README.md -O docs/burp-extensions.md;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone docs/pentest-book? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    git clone https://github.com/six2dez/pentest-book docs/pentest-book;
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
    mkdir -p bin/nse;
    wget https://raw.githubusercontent.com/dolevf/nmap-graphql-introspection-nse/master/graphql-introspection.nse -O bin/nse/graphql-introspection.nse;
    git clone https://github.com/binarytrails/nmap-parse-output bin/nmap-parse-output;
        ln -fs nmap-parse-output/nmap-parse-output bin/nmap-parse;
    wget https://raw.githubusercontent.com/Anon-Exploiter/SUID3NUM/master/suid3num.py -O bin/suid3num.py;
    wget https://raw.githubusercontent.com/reider-roque/linpostexp/master/linprivchecker.py -O bin/linprivchecker.py;
        chmod +x bin/linprivchecker.py;
    wget https://raw.githubusercontent.com/swarley7/linuxprivchecker/master/linuxprivchecker.py -O bin/linprivchecker3.py;
        chmod +x bin/linprivchecker3.py;
    wget https://raw.githubusercontent.com/21y4d/nmapAutomator/master/nmapAutomator.sh -O bin/nmapAutomator.sh;
        chmod +x bin/nmapAutomator.sh;
    git clone https://github.com/binarytrails/pyrate.git bin/pyrate;
        cd bin/pyrate && ./install.py && cat run.py; cd ../../; python3 -m pyrate --help;
    git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite bin/peass;
        ln -fs peass/linPEAS/linpeas.sh bin/linpeas.sh;
        ln -fs ../peass/winPEAS/winPEASbat/winPEAS.bat bin/win/winpeas.bat;
    git clone https://github.com/SecureAuthCorp/impacket.git bin/impacket;
    git clone https://github.com/binarytrails/yaptest.git bin/yaptest;
    git clone https://github.com/rezasp/joomscan.git bin/joomscan;
    echo "go get github.com/tomnomnom/waybackurls" && go get github.com/tomnomnom/waybackurls;
      ln -fs ~/go/bin/waybackurls bin/waybackurls;
    git clone https://github.com/maldevel/EmailHarvester bin/email-harvester;
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
