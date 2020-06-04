FROM rocker/shiny:3.6.0

RUN set -eux; \
    apt-get update; apt-get install -y \
    sudo gdebi-core libcurl4-gnutls-dev \
    libcairo2-dev libxt-dev libssl-dev \
    libssh2-1-dev gosu; \
    rm -rf /var/lib/apt/lists/*; \
    gosu nobody true


RUN mkdir /srv/shiny-server/example-app
RUN mkdir /srv/shiny-server/example-app/data

RUN sudo chown -R shiny:shiny /srv/shiny-server

USER shiny

COPY example-app/ui.R /srv/shiny-server/example-app/ui.R
COPY example-app/server.R /srv/shiny-server/example-app/server.R

RUN rm /srv/shiny-server/index.html

USER root

COPY shiny-server.sh /usr/local/bin/shiny-server.sh
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf

EXPOSE 80

CMD ["/usr/local/bin/shiny-server.sh"]
