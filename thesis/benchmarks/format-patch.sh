set -e

if [ -z "$1" ]
then
  echo "Usage: $0 <ghc-fork>"
  exit 1
fi

forkdir=$1; shift

mkdir -p patches

git -C $forkdir format-patch 0cee252 --stdout > patches/ghc-8.2-$(git -C $forkdir rev-parse --abbrev-ref HEAD).patch
