#!/bin/bash
# The template names are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5).
# The first two are for IDS evasion. 
nmap -v -Pn -sV --version-light --version-trace -T2 -F --script vulners --script-args mincvss=3.0 $@
