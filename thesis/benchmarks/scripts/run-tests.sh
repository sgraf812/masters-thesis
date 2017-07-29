set -e
set -o pipefail

name="$(date +'%Y-%m-%d-%H-%M')"
clean=yes
patch="$(basename $PWD)"

echo Running the testsuite
echo name: $name

echo ready to go...
#sleep 10

if [ "$clean" = yes ]
then
	make distclean
	echo "BuildFlavour = devel2" | cat - mk/build.mk.sample > mk/build.mk
	perl boot
	./configure $cachegrindconf
	make 2>&1 |
		tee /logs/buildlog-test-$patch-$name.log
else
	make -C ghc 2 -j8
fi
make -C testsuite THREADS=8 2>&1 |
    tee /logs/testlog-$patch-$name.log
