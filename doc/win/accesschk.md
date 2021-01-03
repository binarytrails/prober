# accesschk

> kind of accesses specific users or groups have to resources including files, directories, Registry keys, global objects and services

https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk

## /accepteula

Flag to accept their EULA otherwise pop-up in GUI. Since we run in CLI, we need it.

## permissions each user level has

    accesschk.exe /accepteula -ucqv *
    accesschk.exe /accepteula -ucqv <service>

## write access to a service with a certain user level

    accesschk.exe /accepteula -uwcqv "Authenticated Users" *

## get permissions per service

    accesschk.exe /accepteula -ucqv <service>
