# Mapserver for Docker
FROM ubuntu:18.04
MAINTAINER Jose Checa <jcheca@uco.es>
ENV TERM xterm

# Update and upgrade system
RUN apt-get -qq update --fix-missing && apt-get -qq --yes upgrade

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
#RUN update-locale LANG=C.UTF8

# Install mapcache compilation prerequisites
RUN apt-get install -y software-properties-common \
    g++ \
    make \
    cmake \
    wget \
    git \
    bzip2 \
    apache2 \
    curl \
    apt-utils

# Personal PHP 5.6 on Ubuntu 18.04
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install -y php5.6 \
    php5.6-dev \
    libproj-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libcairo2-dev \
    libgdal-dev \
    libgpgme11-dev \
    libgeos-dev \
    libjpeg-dev \
    libogre-1.9-dev \
    libxml2-dev

ADD resources /tmp/resources

#ADD setup.sh /setup.sh
#RUN chmod 0755 /setup.sh
#RUN /setup.sh

# Enable these Apache modules
RUN  a2enmod actions cgi alias
RUN cp /tmp/resources/000-default.conf /etc/apache2/sites-available

# Link to cgi-bin executable
#RUN chmod o+x /usr/local/bin/mapserv
#RUN ln -s /usr/local/bin/mapserv /usr/lib/cgi-bin/mapserv
#RUN chmod 755 /usr/lib/cgi-bin

EXPOSE 80

ENV HOST_IP `ifconfig | grep inet | grep Mask:255.255.255.0 | cut -d ' ' -f 12 | cut -d ':' -f 2`

CMD apachectl -D FOREGROUND
