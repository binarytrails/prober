 Get-ChildItem "C:\Users\$env:USERNAME\AppData" -Recurse -Filter *.dll -ErrorAction SilentlyContinue | Select-Object FullName
