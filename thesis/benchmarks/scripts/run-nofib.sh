test -d nofib || { echo "No nofib found" ; exit 1 ;  }

set -e
set -o pipefail

mode=norm
variant=""
cachegrind=
cachegrindconf=
NoFibRuns=20
clean=yes


# defaults for the thesis
# full script at https://github.com/nomeata/ghc-devscripts

mode=slow
variant="$variant-slow"

cachegrindconf=--disable-large-address-space
cachegrind=EXTRA_RUNTEST_OPTS=-cachegrind
NoFibRuns=1
variant="$variant-cachegrind"

echo mode: $mode
echo variant: $variant

#git fetch origin

name="$(date +'%Y-%m-%d-%H-%M')"

patch="$(basename $PWD)"

echo name: $name

echo ready to go...
#sleep 10

if [ "$clean" = yes ]
then
	make distclean
	echo "BuildFlavour = bench" | cat - mk/build.mk.sample > mk/build.mk
    perl boot
	./configure $cachegrindconf
	/usr/bin/time -o buildtime-$name make 2>&1 |
		tee /logs/buildlog-$patch-$name.log
else
	make -C ghc 2 -j8
fi
cd nofib/
make clean
make boot
(make $cachegrind NoFibRuns=$NoFibRuns mode=$mode) 2>&1 | tee /logs/$patch-$name$variant.log
# fix a problem with nofib logs from cachegrind
sed -i -e 's/,  L2 cache misses/, 0 L2 cache misses/' /logs/$patch-$name$variant.log
