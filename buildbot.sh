#! /bin/bash
source .env
source colors.sh
set -e
echo -e "${YELLOW}[+]${NC} Building docker images for bot version: $version"
echo -e "${YELLOW}[+]${NC} Running in $ENV envoriment"

if [ "x$ENV" = "xdev" ] ; then
    docker build -t dobrevstatslistener:$version -f ./bots/listener/Dockerfile . --build-arg ENV=dev
    docker build -t dobrevstatsresponse:$version -f ./bots/response/Dockerfile . --build-arg ENV=dev ; 
else
    docker build -t dobrevstatslistener:$version -f ./bots/listener/Dockerfile . 
    docker build -t dobrevstatsresponse:$version -f ./bots/response/Dockerfile . ;
fi

declare -- ANSWER=;
until [[ $ANSWER =~ [yYnN] ]]; do
	read -rp "${GREEN}[?]${NC} Start the bot? (y/n): " ANSWER
done

if ! [[ $ANSWER =~ [nN] ]]; then
	./startbot.sh
fi