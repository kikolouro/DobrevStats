#! /bin/bash
source .env
source colors.sh
echo -e "${YELLOW}[+]${NC} Starting bot in version: $version"
echo -e "${YELLOW}[+]${NC} Running in $ENV envoriment"

function failure
{
	echo -e "${RED}[!] error: $*"
	exit 1
}
: > volume/status
echo "start" >> volume/status
if [ "x$ENV" = "xdev" ] ; then
    docker run -it --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
    #docker run -v volume:/ext/status  --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
else 
    docker run -v status:/ext/status  --detach --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
    docker run -v status:/ext/status  --detach --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
fi 
