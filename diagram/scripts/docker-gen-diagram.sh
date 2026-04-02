#docker pull minlag/mermaid-cli
docker run --rm -u $(id -u):$(id -g) -v "$(pwd):/data" minlag/mermaid-cli -i /data/sources/diagram.mmd -o /data/images/diagram.png -t dark -b "#000000" -s 3
