#!/bin/bash

if [ "$1" == "" ]; then
  echo "Script will iterate though a directory and run the unix "file" command on each file."
  echo "Useful to help find if the wrong types of images are in a directory you are trying to use for computer image classification."
  echo "Run it like this: \"./file_type_list.sh /mnt/disk/folder_full_of_images\""
  echo "You can filter the results using grep -v to find images with wrong format to analyise."
  echo "E.G. \"./file_type_list.sh /mnt/disk/folder_full_of_images |grep -v JPEG\" will show any images in the folder that are not JPEG formated"
  exit 1
fi

for file in $1/*; do
  #echo "$(basename "$file")"
  file "$file"
done
