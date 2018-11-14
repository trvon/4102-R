# 4102-R Semester Group Projects

@Authors: Hadi, Kyle, Trevon

## Repository Structure
- intro/
	Initial Assignment

- project/
	This is our semester term project
	TODO:
	- [ ] Build functions for handling data with R
		- [ ] Handle reading live scraped data
		Functions that show features in data
		- [ ] Predictive pricing (per data, or best price)
		- [ ] Best price of items
	- [ ] Build functions for handling scraped data
		- [x] Connect Python Scaper to Postgres Docker Image
		- [ ] Move Scraped data into database
		- [ ] Implement clean close
	- [ ] Display data in browser via Flask (This would be cool)
	
	### Building 
	I have been testing everything within a UNIX environment. To start
	environment run:
	``` 
	./build.sh 
	```

	### Dependencies
	- docker
	- python3
	- R

	#### Debian Specific
	```
	# apt install libpq-dev python3 python3-pip libcurl4-openssl-dev
	# pip install Scapy
	```
