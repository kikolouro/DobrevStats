#! /bin/bash
source .env
echo "[+] Creating docker image for bot version: $version"
echo "[+] Running in $env envoriment"

if [ "x$env" = "xdev" ] ; then
docker build -t dobrevstats:$version . --build-arg ENV=dev ; else
docker build -t dobrevstats:$version . ; 
fi
if [ "x$env" = "xdev" ] ; then
    docker run --restart always --name dobrevstatsV$version dobrevstats:$version ; else 
    docker run --restart always --detach --name dobrevstatsV$version dobrevstats:$version ; 
fi 
