# Define the input file with the list of IPs or hostnames
$inputFile = "targets.txt" # Update with the path to your input file

# Define the output file
$outputFile = "PingResults.csv" # Update with the desired output path

# Initialize the output file
"IP,Status" | Out-File -FilePath $outputFile

# Read the list of targets
$targets = Get-Content -Path $inputFile

# Loop through each target
foreach ($target in $targets) {
    # Ping the target
    $pingResult = Test-Connection -ComputerName $target -Count 3 -Quiet

    # Determine the status
    if ($pingResult) {
        $status = "Responsive"
    } else {
        $status = "Unresponsive"
    }

    # Write the result to the output file
    "$target,$status" | Out-File -FilePath $outputFile -Append
}

Write-Host "Ping results saved to $outputFile"
