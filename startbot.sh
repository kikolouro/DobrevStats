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

function update
{

	echo "[+] installing DobrevStats upgrades"

	# Grab new changes
	git pull || failure "git pull failed"

}

echo "[+] checking for updates"

git remote update >/dev/null
if git status -uno | grep "branch is up to date with" >/dev/null; then
	echo "[+] DobrevStats is up to date!"
else
	echo "[*] newer DobrevStats version avaiable (you should rebuild your docker)"
	update
fi


if [ "x$ENV" = "xdev" ] ; then
    docker run -v $(pwd)/volume:/ext -d --name dobrevstatsresponseV$version dobrevstatsresponse:$version && docker run -v $(pwd)/volume:/ext --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first" ;
else 
    docker run -v $(pwd)/volume:/ext --detach --name dobrevstatsresponseV$version dobrevstatsresponse:$version || failure "Build the image first" ; 
    docker run -v $(pwd)/volume:/ext  --detach --name dobrevstatslistenerV$version dobrevstatslistener:$version || failure "Build the image first"
fi 
