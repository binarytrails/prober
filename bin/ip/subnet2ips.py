#!/usr/bin/python
# Vsevolod Ivanov <seva@binarytrails.net>

import sys, ipaddress
subnet = sys.argv[1]
ips = [str(ip) for ip in ipaddress.IPv4Network(subnet, strict=False)]
for ip in ips:
    print(ip)
