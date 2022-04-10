git clone https://github.com/Hackplayers/evil-winrm bin/evil-winrm
cd bin/evil-winrm
gem install winrm winrm-fs stringio logger fileutils
ruby evil-winrm.rb --help
cd ../../
