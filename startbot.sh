#! /bin/bash
source .env
echo "[+] Creating docker image for bot version: $version"
docker build -t dobrevstats-v$version .