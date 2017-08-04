#! /usr/bin/env bash

files3="nofib-table-alloc nofib-table-instrs"
benchdir=$(cd $(dirname $0) && pwd)

for file in $files3
do
  cat $benchdir/../../thesis/benchmarks/usage-anal-$file.tex | cut -d'&' -f1,2,4 > $benchdir/usage-anal-$file.tex
done

files6="nofib-comp-table ghc-comp-table"

for file in $files6
do
  cat $benchdir/../../thesis/benchmarks/usage-anal-$file.tex | cut -d'&' -f1,2,4,5,7 > $benchdir/usage-anal-$file.tex
done
