#!/bin/bash

set -e

sudo docker build -t graf-thesis .

mkdir -p $PWD/logs
mkdir -p $PWD/patches
mkdir -p $PWD/scripts

for p in patches/*
do
  name="$(basename $p .patch)"
  sudo docker run -i --tty --rm -v $PWD/logs:/logs -v $PWD/patches:/patches -v $PWD/scripts:/scripts graf-thesis /scripts/patch-and-run.sh $name
done
