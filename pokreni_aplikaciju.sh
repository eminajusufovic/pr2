#!/bin/bash


docker network inspect app-network >/dev/null 2>&1 || docker network create app-network

docker-compose up -d postgres


sleep 10


docker-compose up -d backend


docker-compose ps


echo -e "\n\e[1;32mAplikacija je pokrenuta!\e[0m"
echo -e "Pristupite na: \e[1;34mhttp://localhost:5002\e[0m\n"