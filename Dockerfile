FROM ubuntu:12.04

ENV MAJOR_VERSION 3
ENV VERSION 3.0
ENV PHP_BUILD_DIR /root/php
ENV DBC_PATCH_FILE /tmp/db.c-patch.txt

COPY db.c-patch.txt $DBC_PATCH_FILE

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y build-essential && \
    # Download and extract source code
    mkdir -p $PHP_BUILD_DIR && \
    wget http://museum.php.net/php$MAJOR_VERSION/php-$VERSION.tar.gz && \
    tar -xvvf php-$VERSION.tar.gz -C $PHP_BUILD_DIR && \
    rm php-$VERSION.tar.gz && \
    # Patch db file
    cd $PHP_BUILD_DIR/php-$VERSION/functions && \
    patch < $DBC_PATCH_FILE && \
    rm $DBC_PATCH_FILE && \
    cd .. && \
    # Install
    ./configure && \
    sed -i -e 's/LIBS = \(.*\)/LIBS = \1 -lresolv/' Makefile && \
    CFLAGS=Wno make && \
    make install

CMD ["php", "-v"]
