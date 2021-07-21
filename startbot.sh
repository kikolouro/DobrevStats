#! /bin/bash
source .env
source colors.sh
echo -e "${YELLOW}[+]${NC} Starting bot in version: $version"
echo -e "${YELLOW}[+]${NC} Running in $ENV envoriment"
set -e
function failure
{
	echo -e "${RED}[!] error: $*"
	exit 1
}

if [ "x$ENV" = "xdev" ] ; then
    docker run -v $(pwd)/volume:/ext -d --name dobrevstatsresponseV$version dobrevstatsresponse:$version && docker run -v $(pwd)/volume:/ext --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first" ;
else 
    docker run -v $(pwd)/volume:/ext --detach --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
    docker run -v $(pwd)/volume:/ext  --detach --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
fi 
