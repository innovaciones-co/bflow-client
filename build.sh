#!/bin/bash

VERSION=$(cat pubspec.yaml| grep version: | grep -oP '(?<=version: )\d+\.\d+\.\d+')
IMAGE="sdtorresl/bflow-client"

docker build -t $IMAGE:$VERSION .
docker image push $IMAGE:$VERSION