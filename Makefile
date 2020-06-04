.PHONY: docker shiny-server docker-bash docker-shiny clean data

clean:
	rm data/*

data:
	Rscript R/modify-data.R

docker:
	docker build -t shiny-server-example -f Dockerfile .

docker-bash:
	docker run --rm -it -p 80:80 -v ~/Projects/_edu/shiny-server-details/data/:/srv/shiny-server/example-app/data/ shiny-server-example /bin/bash

shiny-server-with-refresh: data
	docker run --rm -p 80:80 \
	-v ~/Projects/_edu/shiny-server-details/data/example-data.csv:/srv/shiny-server/example-app/data/example-data.csv \
	-v ~/Projects/_edu/shiny-server-details/data/restart.txt:/srv/shiny-server/example-app/restart.txt \
	shiny-server-example

shiny-server-wo-refresh: data
	docker run --rm -p 80:80 \
	-v ~/Projects/_edu/shiny-server-details/data/example-data.csv:/srv/shiny-server/example-app/data/example-data.csv \
	-v ~/Projects/_edu/shiny-server-details/data/restart.txt:/srv/shiny-server/example-app/restart.txt \
	shiny-server-example

