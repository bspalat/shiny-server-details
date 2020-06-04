.PHONY: docker shiny-server docker-bash docker-shiny

docker:
	docker build -t shiny-server-example -f Dockerfile .

docker-bash:
	docker run --rm -it -p 80:80 -v ~/Projects/_edu/shiny-server-details/data/:/srv/shiny-server/example-app/data/ shiny-server-example /bin/bash

docker-shiny:
	docker run --rm -p 80:80 shiny-server-example

shiny-server:
	docker run --rm -p 80:80 -v ~/Projects/_edu/shiny-server-details/data/:/srv/shiny-server/example-app/data/ shiny-server-example
