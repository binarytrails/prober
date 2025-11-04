param(
    [string]$Username,
    [string]$Password,
    [string]$Domain = $env:USERDOMAIN
)

Add-Type -AssemblyName System.DirectoryServices.AccountManagement

$context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('Domain', $Domain)
if ($context.ValidateCredentials($Username, $Password)) {
    Write-Host "Credentials are valid for user '$Username'."
} else {
    Write-Host "Invalid credentials for user '$Username'."
}
