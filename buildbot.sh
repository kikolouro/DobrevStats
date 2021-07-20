#! /bin/bash
source .env
source colors.sh
echo -e "${YELLOW}[+]${NC} Building docker images for bot version: $version"
echo -e "${YELLOW}[+]${NC} Running in $ENV envoriment"
: > status
echo "build" >> status
if [ "x$ENV" = "xdev" ] ; then
    docker build --progress tty -t  dobrevstatslistener:$version -f ./bots/listener/Dockerfile . --build-arg ENV=dev
    docker build -o -t dobrevstatsresponse:$version -f ./bots/response/Dockerfile . --build-arg ENV=dev ; 
else
    docker build -t dobrevstatslistener:$version -f ./bots/listener/Dockerfile . 
    docker build -t dobrevstatsresponse:$version -f ./bots/response/Dockerfile . ;
fi