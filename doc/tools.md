# tools

Everything is from Linux perspective. It doens't mean some of them don't run on Windows but pentesting is generally performed from Linux. Of course once inside of Windows, there are Windows tools used and documented in a separate section below.

## training

https://github.com/OWASP/SecurityShepherd

https://github.com/rapid7/metasploitable3

## intelligence

Semi-automatic OSINT framework and package manager

https://github.com/kpcyrd/sn0int

JARM is an active Transport Layer Security (TLS) server fingerprinting tool.

https://github.com/salesforce/jarm

## web

Smuggler - An HTTP Request Smuggling / Desync testing tool written in Python 3

https://github.com/defparam/smuggler

Automatically find security vulnerabilities in your web applications while you are developing and testing your applications.

https://github.com/zaproxy/zaproxy

## protocols

### sql

Automatic SQL injection and database takeover tool

https://github.com/sqlmapproject/sqlmap

### rdp

Scans for accessibility tools backdoors via RDP

https://github.com/linuz/Sticky-Keys-Slayer

## mitm

Responder is a LLMNR, NBT-NS and MDNS poisoner, with built-in HTTP/SMB/MSSQL/FTP/LDAP rogue authentication server supporting NTLMv1/NTLMv2/LMv2, Extended Security NTLMSSP and Basic HTTP authentication.

The Browser Exploitation Framework Project

https://github.com/beefproject/beef

## frameworks

Exploits and Security Tools Framework

https://github.com/C0reL0ader/EaST

## privilege escalation

Automates elevation of privileges in Linux like systems

https://github.com/guifre/Elevator

PEASS - Privilege Escalation Awesome Scripts SUITE (with colors)

https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite

## reverse engineering

UNIX-like reverse engineering framework and command-line toolset

https://github.com/radareorg/radare2

https://book.rada.re/first_steps/intro.html

Exploit Development and Reverse Engineering with GDB Made Easy

https://github.com/pwndbg/pwndbg

## crypto

Web app and framework offering modular conversion, encoding and encryption

https://github.com/cryptii/cryptii

## bruteforcer

World's fastest and most advanced password recovery utility

https://github.com/hashcat/hashcat

Advanced offline password cracker, which supports hundreds of hash and cipher types, and runs on many operating systems, CPUs, GPUs, and even some FPGAs

https://github.com/openwall/john

Patator is a multi-purpose brute-forcer, with a modular design and a flexible usage.

https://github.com/lanjelot/patator

### wordlists

https://github.com/xajkep/wordlists

https://github.com/danielmiessler/SecLists

## windows

### reconnnaissance

The SNMP protocol is a stateless, datagram oriented protocol. An SNMP scanner is a program that sends SNMP requests to multiple IP addresses, trying different community strings and waiting for a reply. Unfortunately SNMP servers don't respond to requests with invalid community strings.

https://github.com/trailofbits/onesixtyone

### get into the winners party

Python library for Windows Remote Management (WinRM)

https://github.com/diyan/pywinrm

### powershell

PowerSploit - A PowerShell Post-Exploitation Framework

https://github.com/ZeroDayLab/PowerSploit

### privilege escalation

Local Privilege Escalation tool, from a Windows Service Accounts to NT AUTHORITY\SYSTEM. RottenPotatoNG and its variants leverages the privilege escalation chain based on BITS service having the MiTM listener on 127.0.0.1:6666 and when you have SeImpersonate or SeAssignPrimaryToken privileges. During a Windows build review we found a setup where BITS was intentionally disabled and port 6666 was taken.

https://github.com/ohpe/juicy-potato

https://github.com/ivanitlearning/Juicy-Potato-x86

### password dumping

Source code for HppDLL - local password dumping using MsvpPasswordValidate hooks

https://github.com/last-byte/HppDLL
