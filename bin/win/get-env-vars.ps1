Get-Variable |%{ "Name : {0}`r`nValue: {1}`r`n" -f $_.Name,$_.Value }
