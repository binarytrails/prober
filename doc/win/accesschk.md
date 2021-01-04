# accesschk

> kind of accesses specific users or groups have to resources including files, directories, Registry keys, global objects and services

https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk

## /accepteula

Flag to accept their EULA otherwise pop-up in GUI. Since we run in CLI, we need it.

## services permissions

    accesschk.exe /accepteula -ucqv *
    accesschk.exe /accepteula -ucqv <service>
    accesschk.exe /accepteula -uwcqv "Authenticated Users" *
    accesschk.exe /accepteula "power users" c:\windows\system32
    accesschk.exe /accepteula users -cw *
    accesschk.exe /accepteula -uwcqv first.last *
    accesschk.exe /accepteula -ucqv NetLogon

## weak permissions

    # folder
    accesschk.exe /accepteula -uwdqs Users c:\
    accesschk.exe /accepteula -uwdqs "Authenticated Users" c:\
    # file
    accesschk.exe /accepteula -uwqs Users c:\*.*
    accesschk.exe /accepteula -uwqs "Authenticated Users" c:\*.*

## registery

    accesschk.exe /accepteula -k hklm\software
    accesschk.exe /accepteula -kns jean\leloup hklm\software

    # explicit integrity level
    accesschk.exe /accepteula -e -s C:\Users\Administrator

    # global objects that everyone can modify
    accesschk.exe /accepteula -wuo everyone \basednamedobjects
