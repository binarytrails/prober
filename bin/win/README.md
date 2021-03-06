# wmic-info - Retrieve system info.
Uses WMIC to gather various important informatoon about a windows host and dump it to HTML.

# icacls.bat - Weak permissions on Services.
* Script that queries all services. 
* Removes default tasks and any Microsot related. 
* Then checks the  BINARY_PATHS for any exeuctables that have the Everyone or Usergroup set with RW access.

# schcheck.bat - Weak permissions on scheduled task executables.
* Lists all schededuled tasks. 
* Runs list of executables against icacls and checks if any allow Everyone RW permissions.

# adduser.c - Creates user and adds to administrator group.
* Creates a user called sharepoint with password sharepoint. Add's user to local administrators group. 
* To cross compile on kali - i686-w64-mingw32-gcc -o useradd.exe useradd.c 


# Powershell/powershell_download_file.txt - Create wget powershell script to download external files.

* Copy file contents to clipboard using > `cat powershell_download_file.txt | xclip -selection clipboard`
* Paste into Windows command prompt which will create a **wget.ps1**
* `powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1`

# Privelege/Accesschk-2003-xp.exe & accesschk-2008-vista.exe
## Identify the level of access a particular user or groups have to files, directories, Registry keys.

When executing any of the sysinternals tools for the first time the user will be presented with a GUI
pop-up to accept the EULA. This is obviously a big problem, however we can add an extra command line flag
to automatically accept the EULA.

     accesschk.exe /accepteula 

The following command reports the accesses that the Power Users account has to files and directories in \Windows\System32:

     accesschk "power users" c:\windows\system32

This command shows which Windows services members of the Users group have write access to:

     accesschk users -cw *

Check what access authenticated users have to services.

     accesschk.exe -uwcqv "Authenticated Users" *

Check which Windows services a user called adam.dale has write access to:

      accesschk.exe -uwcqv adam.dale *

Check to see what access permissions are set on the serice called NetLogon

     accesschk.exe -ucqv NetLogon

Find all weak folder permissions per drive.

     accesschk.exe -uwdqs Users c:\
     accesschk.exe -uwdqs "Authenticated Users" c:\

Find all weak file permissions per drive.

     accesschk.exe -uwqs Users c:\*.*
     accesschk.exe -uwqs "Authenticated Users" c:\*.*


To see what Registry keys under HKLM\CurrentUser a specific account has no access to:

     accesschk -kns austin\mruss hklm\software

To see the security on the HKLM\Software key:

     accesschk -k hklm\software

To see all files under \Users\Mark on Vista that have an explicit integrity level:

     accesschk -e -s c:\users\mark

To see all global objects that Everyone can modify:

     accesschk -wuo everyone \basednamedobjects

# Powershell/folderperms.ps1
## Checks for folders in the current PATH variable that are writeable for all authenticated users.

When new folders are created in the root it is writeable for all authenticated users by default. The “NT AUTHORITY\Authenticated Users:(I)(M)” gets added to the folder where M stands for modify access. So any application that gets installed on the root can be tampered with by a non-admin user. 

The script checks for any of those folders that are writeable by authenticated users.
