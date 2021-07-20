#! /bin/bash
source .env
echo "[+] Creating docker image for bot version: $version"
echo "[+] Running in $ENV envoriment"

if [ "x$ENV" = "xdev" ] ; then
    docker-compose build --build-arg version=$version --build-arg ENV=$ENV
    docker-compose up --build;
else 

    docker-compose build --build-arg version=$version
    docker-compose up -d
    
fi 
