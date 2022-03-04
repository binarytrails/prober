# ./http_get_status_codes.sh list.txt
for host in $(cat $1); do echo -n "$host " && \
    curl -s -o /dev/null -w "%{http_code}" "$host" && echo; done
