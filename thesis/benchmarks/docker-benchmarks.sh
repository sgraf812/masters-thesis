#!/bin/bash

set -e

sudo docker build -t graf-thesis docker-setup

mkdir -p $PWD/logs
mkdir -p $PWD/patches

for p in patches/*
do
  name="$(basename $p .patch)"
  sudo docker run -i --tty --rm -v $PWD/logs:/logs -v $PWD/patches:/patches graf-thesis ./patch-and-run.sh $name
done
