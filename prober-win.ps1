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

        Example: '$AVERAGE="y"; $HEAVY=""; ./prober-win.ps1'

        Project source: https://github.com/binarytrails/prober

""";

echo "Installing Package manager..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

echo "Installing tools for Revision history"...
choco install -y git
$Env:path += ";C:\Program Files\Git\bin"

echo "Installing tools for Editors"...
choco install -y vim

echo "Installing tools for Archives"...
choco install -y unzip

echo "Installing tools for Programming"...
choco install -y python
echo "Installing tools for binary path as well as pip, easy_install in scripts
$Env:path += ";C:\Python39;C:\Python39\Scripts"

echo "Installing tools for Connectivity"...
choco install -y openvpn
$Env:path += ";C:\Program Files\OpenVPN\bin"

echo "Installing tools for Networking"...
choco install -y netcat # nc.exe
choco install -y nmap
$Env:path += ";C:\Program Files (x86)\Nmap"

echo "Installing tools for Binaries"...
choco install -y dnspy  # analyser / editor

echo "------------------------------------------------------------------------------"

LIGHT="y";
AVERAGE="";
HEAVY="";

# docs
if ($LIGHT -ne "y" -And $LIGHT -ne "n"){
    #read -p "Do you want to clone docs? [light] (y/n)? " LIGHT;
    $LIGHT = Read-Host 'What is your username?'
}
if ($LIGHT -eq "y"){
    mkdir docs;
    wget https://raw.githubusercontent.com/six2dez/OSCP-Human-Guide/master/oscp_human_guide.md -O docs/everything-1.md;
    git clone https://github.com/six2dez/pentest-book docs/pentest-book;
    git clone https://github.com/binarytrails/notes.git docs/notes;
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git docs/payloadsallthethings;
    git clone https://github.com/GTFOBins/GTFOBins.github.io.git docs/gtfo-bins;
}
if ($AVERAGE -ne "y" -And $AVERAGE -ne "n"){
    $AVERAGE = "Do you want to clone docs/hacktricks? [average] (y/n)? ";
}
if ($AVERAGE -eq "y"){
    git clone https://github.com/carlospolop/hacktricks.git docs/hacktricks;
}
if ($AVERAGE -ne "y" -And $AVERAGE -ne "n"){
    $AVERAGE = "Do you want to clone docs/ired.team? [average] (y/n)? ";
}
if ($AVERAGE -eq "y"){
    git clone https://github.com/mantvydasb/RedTeam-Tactics-and-Techniques.git docs/ired-team;
      #ln -fs ./ired-team/offensive-security-experiments/offensive-security-cheetsheets/README.md docs/cheatsheets-ired-team.md;
      New-Item -ItemType SymbolicLink -Path "docs/cheatsheets-ired-team.md" -Target "./ired-team/offensive-security-experiments/offensive-security-cheetsheets/README.md"
}
