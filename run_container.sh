#!/bin/bash

DIR_NAME=`dirname $1`
BASE_NAME=`basename $1`


info () {
  echo "To run container please pass DIR name and IMAGE id to script as \$1 and \$2..."
  echo "NOTE: this script will run the container as the same uid/gid you run it from..."
  echo "Assuming you have this folder: \"/mnt/ssd_2/tensorflow/classifier/chicken_fox/\"..."
  echo "And within this folder you have a data/chicken and data/fox folders with images of chickens and foxes in the respective folders..."
  echo "You would run: ./run_container.sh /mnt/ssd_2/tensorflow/classifier/chicken_fox/"
  echo "NOTE: you can provide your own container image id in \$2 to launch your own one built one"
  echo "Lets say you ran this and it failed for some reason, how annoying! you can add "debug" into \$2 to enter a bash shell in the container as uid root"
  exit 1
}

if [ -z "$1" ]; then
  info
fi

if [ -z "$2" ]; then
  IMAGE=xitation/tensorflow-hub-make_image_classifier
fi

if [ "$2" == "debug" ]; then
  IMAGE=xitation/tensorflow-hub-make_image_classifier
  docker run --network="lan" -v $DIR_NAME:/classifier -e DIR="$BASE_NAME" -it $IMAGE bash
  exit 0
fi

echo "Path provided to analyise $1"
echo "Extracted directory for docker -v mount: $DIR_NAME"
echo "Extracted DIR variable required for entrypoint.sh script: $BASE_NAME"

docker run --network="lan" -u $(id -u):$(id -g) -v $DIR_NAME:/classifier -e DIR="$BASE_NAME" $IMAGE

