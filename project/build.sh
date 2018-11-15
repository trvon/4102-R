#!/bin/bash
# Checking if docker is Installed
if [ -z "$(command -v docker)" ]; then
	echo "Install Docker"
	exit 1
fi

if [ -z "$(docker ps -l | grep postgres)" ]; then
	# Run docker
	sudo docker run --name postgres -e POSTGRES_PASSWORD=r_password -d --network host postgres # -U postgres
fi

# HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgres)

# Checking for python3
if [ -z "$(command -v python3)" ]; then
	echo "Install python3 and pip"
	exit 1	
fi

# Install requirements for python
2>/dev/null 1>/dev/null pip3 install -r SCRAPE/requirements.txt

# Run R and python files
DIR=$(pwd)
cd SCRAPE/crawler && 2>/dev/null 1>/dev/null scrapy crawl AmazonProduct
cd $DIR && 2>/dev/null Rscript main.R 

# Clean Container
# docker stop postgres
# docker rm postgres
echo -e "\nWould you like to clean the docker image?(Y/n)\n"
read answer

case "$answer" in 
	y|Y) 1>/dev/null docker stop postgres && 1>/dev/null docker rm postgres && echo "Container and data deleted" ;;
	*) echo "Exiting!";;
esac
