#! /bin/bash
source .env
source colors.sh
echo -e "${RED}[-]${NC} Removing images"
docker rmi dobrevstatslistener:$version
docker rmi dobrevstatsresponse:$version
