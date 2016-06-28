# This line allows for using spaces instead of tabs for indentation
.RECIPEPREFIX +=

.DEFAULT_GOAL := all

SHELL=/bin/bash

CONTAINER_NAME=lucasvanlierop-php-past
CONTAINER_TAG=lucasvanlierop/php-past:3.0

all: build_container_image

build_container_image:
    docker build -f Dockerfile -t ${CONTAINER_TAG} .

test: build_container_image
    tests/test-if-version-is-correct ${CONTAINER_NAME} ${CONTAINER_TAG}
