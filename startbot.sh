#! /bin/bash
source .env
source colors.sh
echo -e "${YELLOW}[+]${NC} Starting bot in version: $version"
echo -e "${YELLOW}[+]${NC} Running in $env envoriment"

function failure
{
	echo -e "${RED}[!] error: $*"
	exit 1
}

if [ "x$env" = "xdev" ] ; then
    docker run --restart always --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
    docker run --restart always --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
else 
    docker run --restart always --detach --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
    docker run --restart always --detach --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
fi 
