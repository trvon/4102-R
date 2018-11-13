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
pip install -r SCRAPE/requirements.txt

# Run R and python files
python SCRAPE/main.py & Rscript main.R && fg
# Rscript main.R

# Stop Container
# docker stop postgres
# docker ps -l | awk '{print $2}' | tail -n+2 | xargs -I {} docker stop {}
