curl -s -w "%{http_code}" "https://maps.googleapis.com/maps/api/geocode/json?address=New+York&key=$1" | jq .
