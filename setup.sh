#!/bin/bash

#Install libharfbuzz from source as it is not in a repository

#VERSION=xxx-harfbuzz-0.9.19.tar.bz2
#if [ ! -f /tmp/resources/harfbuzz-0.9.19.tar.bz2 ]; then \
#    wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.19.tar.bz2 -P /tmp/resources/; \
#    fi; \
#    cd /tmp/resources &&\
#    tar xjf harfbuzz-0.9.19.tar.bz2  &&\
#    cd harfbuzz-0.9.19 && \
#    ./configure  && \
#    make  && \
#    make install  && \
#    ldconfig

    git clone https://github.com/mapserver/mapserver /tmp/resources/mapserver && \
    echo "Antes del mkdir" && \
    mkdir -p /tmp/resources/mapserver/build && \
    cd /tmp/resources/mapserver/build && \
    cmake /tmp/resources/mapserver/ \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DWITH_CLIENT_WFS=ON \
          -DWITH_CLIENT_WMS=ON \
          -DWITH_CURL=ON \
          -DWITH_SOS=OFF \
          -DWITH_PHP=ON \
          -DWITH_FCGI=0 \
          -DWITH_PYTHON=OFF \
          -DWITH_SVGCAIRO=OFF \
          -DWITH_GIF=OFF && \
    make  && \
    make install && \
    ldconfig

echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo '<?php phpinfo();' > /var/www/html/info.php
