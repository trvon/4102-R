#!/bin/bash
# Checking if docker is Installed
if [ -z "$(command -v docker)" ]; then
	echo "Install Docker"
	exit 1
fi

# Run docker
sudo docker run --name postgres -e POSTGRES_PASSWORD=r_password -d --network host postgres # -U postgres
# HOST=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgres)

# Checking for python3
if [ -z "$(command -v python3)" ]; then
	echo "Install python3 and pip"
	exit 1	
fi

# Install requirements for python
pip3 install -r SCRAPE/requirements.txt

# Run R and python files
DIR=$(pwd)
cd SCRAPE/crawler && scrapy crawl AmazonProduct
cd $DIR && Rscript main.R 

# Clean Container
# docker stop postgres
# docker rm postgres
echo -n "\nWould you like to clean the docker image?(Y/n)\n"
read answer

case "$answer" in 
	n|N) docker stop postgres && docker rm postgres;;
	*) echo "Exiting!";;
esac
