#! /bin/bash
source .env
echo "[+] Creating docker image for bot version: $version"
docker build -t dobrevstats-v$version .
docker run --restart always --detach --name dobrevstats-v$version dobrevstats-v$version 