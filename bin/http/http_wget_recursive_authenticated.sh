# wget files from authenticated http url recursively
# ./http_wget_recursive_authenticated.sh username password http://myurl.smth:666/path
wget -mkEpnp --http-user=$1 --http-password=$2 --debug $3
