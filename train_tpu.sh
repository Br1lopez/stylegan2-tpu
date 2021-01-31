#!/bin/bash
source "$HOME/bin/activate-tf1"

set -e

export NOISY=1
export DEBUG=1

export TPU_NAME=grpc://10.6.18.162:8470
cores=8

#config="config-a" # StyleGAN 1
config="config-f" # StyleGAN 2

data_dir=gs://brunolg_tpu_512/512_datasets
dataset=002
mirror=false
metrics=none

export LABEL_SIZE=0
#export LABEL_SIZE=full # uncomment this if using labels
export MODEL_DIR=gs://brunolg_tpu_512/512_results
export BATCH_PER=4
export BATCH_SIZE=$(($BATCH_PER * $cores))
export RESOLUTION=512

set -x
exec python3 -m pdb -c continue run_training.py --data-dir "${data_dir}" --config="${config}" --dataset="${dataset}" --mirror-augment="${mirror}" --metrics="${metrics}" "$@"
