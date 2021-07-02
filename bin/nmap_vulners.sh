#!/bin/bash
# The template names are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5).
# The first two are for IDS evasion. 
# Polite mode slows down the scan to use less bandwidth and target machine resources.
# Normal mode is the default and so -T3 does nothing
nmap -v -Pn -sV --version-light --version-trace -T2 -F --script vulners --script-args mincvss=3.0 $@
