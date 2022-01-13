#!/bin/bash

make_image_classifier \
  --image_dir  classifier/$DIR/data/ \
  --tfhub_module https://tfhub.dev/google/tf2-preview/mobilenet_v2/feature_vector/4 \
  --image_size 224 \
  --saved_model_dir classifier/$DIR/model \
  --labels_output_file classifier/$DIR/class_labels.txt \
  --tflite_output_file classifier/$DIR/$DIR.tflite \
  --summaries_dir classifier/$DIR/logs
