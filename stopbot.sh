#! /bin/bash
source .env
source colors.sh
echo -e "${RED}[+]${NC} Stopping Bot"

docker rm -f dobrevstatslistenerV$version
# docker stop dobrevstatsresponseV$version
