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
AVERAGE="y";
#HEAVY="";
#GIGANTIC=""

# temp
mkdir -p ./temp

# [ex]ploits
mkdir -p sploits/extra;
mkdir -p sploits/vba
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone sploit sources? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    git clone https://github.com/qazbnm456/awesome-cve-poc sploits/extra/qazbnm456;
    git clone https://github.com/NHPT/CVE-Exploit-Script sploits/extra/nhpt;
    git clone https://github.com/itm4n/VBA-RunPE sploits/vba/runpe;
fi
#if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
#    read -p "Do you want to clone more sploit sources? [average] (y/n)? " AVERAGE;
#fi
#if [ "$AVERAGE" = "y" ]; then
#fi
if [[ "$HEAVY" != "y" && "$HEAVY" != "n" ]]; then
    read -p "Do you want to clone extra exploits? [heavy] (y/n)? " HEAVY;
fi
if [ "$HEAVY" = "y" ]; then
    git clone https://github.com/zhzyker/exphub sploits/extra/zhzyker;
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
    wget https://gist.github.com/w00tc/486825a0b7c593789b1952878dd86ff5/archive/09ba2049b7d9737096cef161d5c5ddb22fe569dd.zip -O temp/w00tc-notes.zip && mkdir -p docs/w00tc && unzip -j ./temp/w00tc-notes.zip "486825a0b7c593789b1952878dd86ff5-09ba2049b7d9737096cef161d5c5ddb22fe569dd/*" -d docs/w00tc/; rm -rf ./temp/w00tc*;
    git clone https://github.com/LOLBAS-Project/LOLBAS docs/living-off-the-land;
    wget https://raw.githubusercontent.com/S3cur3Th1sSh1t/Pentest-Tools/master/README.md -O docs/pentest-tools.md;
    git clone https://github.com/ihebski/A-Red-Teamer-diaries docs/red-team-diaries;
    wget https://raw.githubusercontent.com/frizb/Hydra-Cheatsheet/master/README.md -O docs/hydra.md;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone docs/pentest-book? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    git clone https://github.com/six2dez/pentest-book docs/pentest-book;
    git clone https://github.com/gnebbia/nmap_tutorial docs/nmap;
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
# extra things using package managers
read -p "Do you want to install python3 bin tools? (y/n)? " PIP3_TOOLS;
if [[ "$PIP3_TOOLS" == "y" ]]; then
    pip3 install -r install/extra.pip
fi
read -p "Do you want to install SIP tools with apt manager? (y/n)? " SIP_TOOLS;
if [[ "$SIP_TOOLS" == "y" ]]; then
    ./install/sippts.apt
fi
# good ol' way
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone bin? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    mkdir -p bin/{nmap,http,ftp,linux,python,hashcat,ssh,extra};
    git clone https://github.com/jtesta/ssh-audit bin/ssh/ssh-audit;
    wget https://raw.githubusercontent.com/eblazquez/fakelib.sh/master/fakelib.sh -O bin/linux/fakelib.sh && chmod +x bin/linux/fakelib.sh;
    mkdir -p bin/nmap/nse;
    wget https://raw.githubusercontent.com/dolevf/nmap-graphql-introspection-nse/master/graphql-introspection.nse -O bin/nmap/nse/graphql-introspection.nse;
    git clone https://github.com/binarytrails/nmap-parse-output bin/nmap/nmap-parse-output;
        ln -fs nmap-parse-output/nmap-parse-output bin/nmap/nmap-parse;
    wget https://raw.githubusercontent.com/Anon-Exploiter/SUID3NUM/master/suid3num.py -O bin/linux/suid3num.py;
    wget https://raw.githubusercontent.com/reider-roque/linpostexp/master/linprivchecker.py -O bin/linux/linprivchecker.py;
        chmod +x bin/linprivchecker.py;
    wget https://raw.githubusercontent.com/swarley7/linuxprivchecker/master/linuxprivchecker.py -O bin/linux/linprivchecker3.py;
        chmod +x bin/linprivchecker3.py;
    wget https://raw.githubusercontent.com/21y4d/nmapAutomator/master/nmapAutomator.sh -O bin/nmap/nmapAutomator.sh;
        chmod +x bin/nmap/nmapAutomator.sh;
    git clone https://github.com/binarytrails/pyrate.git bin/c2/pyrate;
        cd bin/c2/pyrate && ./install.py && cat run.py; cd ../../../; python3 -m pyrate --help;
    git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite bin/peass;
        ln -fs peass/linPEAS/linpeas.sh bin/linux/linpeas.sh;
        ln -fs ../peass/winPEAS/winPEASbat/winPEAS.bat bin/win/winpeas.bat;
    git clone https://github.com/SecureAuthCorp/impacket.git bin/impacket;
    git clone https://github.com/binarytrails/framework/yaptest.git bin/extra/yaptest;
    git clone https://github.com/rezasp/joomscan.git bin/http/joomscan;
    echo "go get github.com/tomnomnom/waybackurls" && go get github.com/tomnomnom/waybackurls;
      ln -fs ~/go/bin/http/waybackurls bin/http/waybackurls;
    git clone https://github.com/maldevel/EmailHarvester bin/osint/email-harvester;
    git clone https://github.com/0xn0ne/weblogicScanner bin/http/weblogic-scanner;
    mkdir -p bin/win/pwsh && git clone https://github.com/samratashok/nishang bin/win/pwsh/nishang;
    git clone https://github.com/bcoles/jira_scan bin/jira-scan;
    git clone https://github.com/MayankPandey01/Jira-Lens bin/jira-lens-scan;
    git clone https://github.com/ihebski/DefaultCreds-cheat-sheet bin/default-creds/;
    wget https://raw.githubusercontent.com/extremecoders-re/pyinstxtractor/master/pyinstxtractor.py -O bin/pyinstxtractor.py;
    git clone https://github.com/zrax/pycdc bin/python/pycdc;
    echo "cmake CMakeLists.txt && make" > bin/python/pycdc/build.sh;
    mkdir -p bin/hashcat/rules/;
    wget https://raw.githubusercontent.com/hashcat/hashcat/master/rules/best64.rule -O bin/hashcat/rules/best64.rule;
    wget https://github.com/NotSoSecure/password_cracking_rules/raw/master/OneRuleToRuleThemAll.rule -O bin/hashcat/rules/OneRuleToRuleThemAll.rule;
    install/./evil-winrm.sh;
fi
if [[ "$AVERAGE" != "y" && "$AVERAGE" != "n" ]]; then
    read -p "Do you want to clone bin/csharp/bc-empire? [average] (y/n)? " AVERAGE;
fi
if [ "$AVERAGE" = "y" ]; then
    mkdir -p bin/win/pwsh && mkdir -p tmp && cd tmp && git clone https://github.com/BC-SECURITY/Empire && mv Empire/empire/server/data/module_source ../bin/win/pwsh/bc-empire && cd ../ && rm -rf ./tmp
fi

# lists
mkdir -p lists;
if [[ "$LIGHT" != "y" && "$LIGHT" != "n" ]]; then
    read -p "Do you want to clone lists? [light] (y/n)? " LIGHT;
fi
if [ "$LIGHT" = "y" ]; then
    wget https://github.com/w0lf-d3n/Quebec_Wordlist/raw/main/quebec.txt -O lists/quebec-passwords.txt;
    git clone https://github.com/xajkep/wordlists lists/xajkep;
    git clone https://github.com/Freeguy1/Wordlistss lists/freeguy1;
    git clone https://github.com/Proviesec/google-dorks lists/google-dorks;
fi
if [[ "$HEAVY" != "y" && "$HEAVY" != "n" ]]; then
    read -p "Do you want to clone seclists? [heavy] (y/n)? " HEAVY;
fi
if [ "$HEAVY" = "y" ]; then
    wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
      && unzip SecList.zip -d lists/seclists \
      && rm -f SecList.zip;
fi
if [[ "$GIGANTIC" != "y" && "$GIGANTIC" != "n" ]]; then
    read -p "Do you want to clone crackstation list? [gigantic] (y/n)? " GIGANTIC;
fi
if [ "$GIGANTIC" = "y" ]; then
    wget -c https://crackstation.net/files/crackstation.txt.gz -O lists/crackstation.txt.gz;
    echo "To expand 5G into 15G do: gunzip lists/crackstations.txt.gz";
fi
