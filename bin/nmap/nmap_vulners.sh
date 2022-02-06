#!/bin/bash
nmap -v -Pn -sV --version-trace --script vulners --script-args mincvss=3.0 $@
