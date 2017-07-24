#!/bin/bash

set -e

logs="$(ls logs/ghc-8.2-base*slow-cachegrind.log|tail -n 1) \
      $(ls logs/ghc-8.2-cocall-full*slow-cachegrind.log|tail -n 1) \
      $(ls logs/ghc-8.2-cocall-approximate-calls*slow-cachegrind.log|tail -n 1) \
      $(ls logs/ghc-8.2-cocall-complete-graphs*slow-cachegrind.log|tail -n 1)"

pruned=""
for log in $logs;
do
  sed '/==nofib== cacheprof/,/Finished making all in cacheprof/d' $log > $log-pruned
  pruned="$pruned $log-pruned"
done

nofib-analyse --columns=Allocs,Instrs -i 0.1  $pruned > usage-anal-nofib-table-all.txt
nofib-analyse --columns=Allocs,Instrs -l -i 0.1  $pruned | ./fixup.pl $logs -0.3 0.0 0 > usage-anal-nofib-table.tex
nofib-analyse --columns=Allocs -l -i 0.1  $pruned | ./fixup.pl $logs 0.0 0.0 1 > usage-anal-nofib-table-alloc.tex
nofib-analyse --columns=Instrs -l -i 0.1  $pruned | ./fixup.pl $logs -3.0 1.0 0 > usage-anal-nofib-table-instrs.tex
nofib-analyse --columns="Comp. Alloc,Comp. Time" -l -i 0.1  $pruned | ./summary-only.pl $logs | grep 'Geometric' | sed -e 's/Geometric Mean/nofib/'> usage-anal-nofib-comp-table.tex

for log in $logs;
do
  rm -f $log-pruned
done

buildlogs="$(ls logs/buildlog-ghc-8.2-base*|tail -n 1) \
      $(ls logs/buildlog-ghc-8.2-cocall-full*|tail -n 1) \
      $(ls logs/buildlog-ghc-8.2-cocall-approximate-calls*|tail -n 1) \
      $(ls logs/buildlog-ghc-8.2-cocall-complete-graphs*|tail -n 1)"
./buildlog.pl $buildlogs > usage-anal-ghc-comp-table.tex
