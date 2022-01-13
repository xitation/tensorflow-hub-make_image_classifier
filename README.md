# tensorflow-hub-make_image_classifier

Docker container and tools to help re-train Google Tensorflow image recognition using the Tensorflow Hub - make_image_classifier python library and tools - https://github.com/tensorflow/hub/tree/master/tensorflow_hub/tools/make_image_classifier.

# About
 I've created this to train Googles image identification Tensorflow Light models how to identify objects. 
 For two reasons:
 1) To learn about ML and image/object classification.
 2) To build a surveillance system to identify Foxes and Chickens in my back yard, to try and protect my Chickens from Foxes.
 
 I found a lot of the Youtube and other blogs/info about how to do this were outdated, and made the process far more complicated than it needed to be. 
 
I plan to use the generated models with Frigate (https://github.com/blakeblackshear/frigate) video surveillance system to send alerts and trigger automations in Home Assistant (https://github.com/home-assistant/core) if a Fox is identified, or if my chickens aren't in bed or get into somewhere they shouldn't (Escape down the driveway).

# Usage
Few tips on how to use this if you are building the container yourself, and then plan to do some re-training of datasets you have.

## Get dataset (images)
You will require a dataset (images) of the thing you wish to identify. 
Depending on what you want to identify, you will need lots of images of the object(s).

I've found that Pinterest and Google Image search both useful for this.

* You can batch download images from Pinterest, using a Chrome/Brave extension called Image Downloader - https://chrome.google.com/webstore/detail/image-downloader/cnpniohnfphhjihaiiggeabnkjhpaldj 
* You can batch download images from Google Image search, using a Chrome/Brave extension called Fatkun Batch Download Image - https://chrome.google.com/webstore/detail/fatkun-batch-download-ima/nnjjahlikiabnchcpehcpkdeckfgnohf

## Setup folder structure for dataset(s)
The downloaded images need to be placed into a folder structure, this folder structure is bind mounded into your docker container under /classifier

My structure looks like this:

    chicken_fox
    ├── data
    │   ├── chicken
    │   │   └── Chicken_1.jpg
    │   └── fox
    │       └── Fox_1.jpg
    ├── logs
    └── model

You can add as many folders under 'data' as you like, the label of the objects in the folder is extracted from the folder name. E.g the analysis was run on the data/chicken folder therefore the label will be chicken.

## Build the image

To build the container image pass a version number as $1 to the build_image.sh script, noting that latest tag is always applied too.

E.g. To build the container with tag v0.1 and latest run the following:
    ./build_image.sh v0.1
    
## Run the container/image
To run container please pass DIR name and an optional IMAGE id to the run_container.sh script as $1 and $2.
**NOTE:** this script will run the container as the same uid/gid you run it from, it's also configured to work with my Docker network "lan". The container will need internet access to download some of the models/data from the Tensorflow repository.

Assuming you have this folder: /mnt/ssd_2/tensorflow/classifier/chicken_fox/
And within this folder you have two folders, data/chicken and data/fox each with images within it.

And you are happy to run with the default container name/tag then you can run this:
 `./run_container.sh /mnt/ssd_2/tensorflow/classifier/chicken_fox/`

You can also provide your own container image id in $2 to launch your own one built one:
`./run_container.sh /mnt/ssd_2/tensorflow/classifier/chicken_fox/ 386372e43b2f`

Lets say you ran this and it failed for some reason, how annoying! you can add "debug" into $2 to enter a bash shell in the container as uid root:
`./run_container.sh /mnt/ssd_2/tensorflow/classifier/chicken_fox/ debug`

## Tools file_type_list.sh
The script file_type_list.sh will iterate though a directory and run the Unix "file" command on each file.
This is useful to help find images with incompatible mime types in a directory you are trying to use for computer image classification.

Run it like this: `./file_type_list.sh /mnt/disk/folder_full_of_images`

You can filter the results using grep -v.
`./file_type_list.sh /mnt/disk/folder_full_of_images |grep -v JPEG` will show any images in the folder that are **NOT** JPEG formatted.
