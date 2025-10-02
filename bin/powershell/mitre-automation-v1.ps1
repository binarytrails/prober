# Set-ExecutionPolicy Bypass -Scope Process -Force;
# powershell -ep bypass

# Generic
function getNow { return (Get-Date).ToString('MM-dd-yyyy_hh-mm-ss-tt') }
$enc = [System.Text.Encoding]::UTF8
function xor {
    param($string, $method, $key)
    $xorkey = $enc.GetBytes($key)

    if ($method -eq "decrypt"){
        $string = $enc.GetString([System.Convert]::FromBase64String($string))
    }

    $byteString = $enc.GetBytes($string)
    $xordData = $(for ($i = 0; $i -lt $byteString.length; ) {
        for ($j = 0; $j -lt $xorkey.length; $j++) {
            $byteString[$i] -bxor $xorkey[$j]
            $i++
            if ($i -ge $byteString.Length) {
                $j = $xorkey.length
            }
        }
    })

    if ($method -eq "encrypt") {
        $xordData = [System.Convert]::ToBase64String($xordData)
    } else {
        $xordData = $enc.GetString($xordData)
    }
    
    return $xordData
}

# Premise
cd ~/Desktop

## Variables
$workdir=echo "$(pwd)\workdir"
$extra=echo "$(pwd)\extra"

if(Test-Path -Path "$workdir")
{
	# archive last (just in case)
	$now=getNow
	Compress-Archive -Path "$workdir" -DestinationPath "$workdir-$now.zip"
	# cleanup last
	Remove-Item -LiteralPath "$workdir" -Force -Recurse
}
mkdir "$workdir"
mkdir "$workdir\mitre"
cd "$workdir"

## Discovery
#
#  [convert]::ToBase64String((Get-Content -path "discovery.ps1" -Encoding byte))
#  powershell -encodedCommand <base64>
#
mkdir mitre
mkdir mitre\discovery

### T1087 Performs domain user and system enumeration.
### T1082 Collects system architecture information. The malware gathers the hostname and
$now=getNow
systeminfo | Out-file "mitre\discovery\T1082_systeminfo_$now.txt"

### T1016 Collects the MAC address and IP address from the victim’s machine.
$now=getNow
getmac | Out-file "mitre\discovery\T1016_getmac_$now.txt"

### T1033 Collects the victim’s username.
$now=getNow
whoami | Out-file "mitre\discovery\T1033_whoami_$now.txt"

### T1087.001 Performs local account discovery.
$now=getNow
net user | Out-file "mitre\discovery\T1033_T1087_net_user_$now.txt"
$now=getNow
### T1069.001 Uses net localgroup administrators to find local administrators.
net user administrator | Out-file "mitre\discovery\T1069_001_net_user_administrator_$now.txt"
$now=getNow
whoami /user | Out-file "mitre\discovery\T1033_whoami_user_$now.txt"
$now=getNow
whoami /all | Out-file "mitre\discovery\T1033_whoami_all_$now.txt"
$now=getNow
whoami /priv | Out-file "mitre\discovery\T1033_whoami_privs_$now.txt"
### T1016 Runs ipconfig /all.
ipconfig /all | Out-file "mitre\discovery\T1033_whoami_privs_$now.txt"

#
## Defense Evasion
#
mkdir mitre\defense-evasion

### T1140 Decrypts strings using single-byte XOR keys.
#. "$extra\xor.ps1"
$now=getNow
xor "shady strings" "encrypt" "7" | Out-file "mitre\defense-evasion\T1140_$now.txt"

### T1027 Uses Base64 to obfuscate commands and the payload.
$now=getNow
[Convert]::ToBase64String([Text.encoding]::UTF8.GetBytes("net user")) | Out-file "mitre\defense-evasion\T1027_net_user_b64_$now.txt"

### T1564.003 Uses "-W Hidden" to set the "WindowStyle" parameter to hidden, concealing PowerShell windows.
$now=getNow
Start-Process powershell.exe -ArgumentList "-W Hidden"
Get-WmiObject Win32_Process -Filter "name = 'powershell.exe'" | Where-Object {$_.CommandLine -match 'powershell.exe" -W Hidden'} | Out-file "mitre\defense-evasion\T1564_003_$now.txt"
Get-WmiObject Win32_Process -Filter "name = 'powershell.exe'" | Where-Object {$_.CommandLine -match 'powershell.exe" -W Hidden'} | Invoke-WmiMethod -Name Terminate

### T1112 Modifies several Registry keys.
$regTempValue=(Get-ItemProperty Registry::HKEY_CURRENT_USER\Environment -Name "TEMP").TEMP
mkdir "$workdir\temp"
Set-ItemProperty -Path Registry::HKEY_CURRENT_USER\Environment -Name "TEMP" -Value "$workdir\temp"
$now=getNow
(Get-ItemProperty Registry::HKEY_CURRENT_USER\Environment -Name "TEMP") | Out-file "mitre\defense-evasion\T1112_$now.txt"
Set-ItemProperty -Path Registry::HKEY_CURRENT_USER\Environment -Name "TEMP" -Value "$regTempValue"

# Wrap up
cd ..
