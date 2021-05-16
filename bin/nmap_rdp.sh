#!/bin/bash
# ./nmap_rdp.sh <target-ip>
nmap --script "rdp-enum-encryption or rdp-vuln-ms12-020 or rdp-ntlm-info" -p 3389 -T4 -Pn $1
