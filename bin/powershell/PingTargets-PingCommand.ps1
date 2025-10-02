cat ips.txt | ForEach-Object { Write-Host "Pinging $_"; ping $_ -n 1 }
