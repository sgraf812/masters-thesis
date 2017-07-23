docker build -t graf-thesis .

foreach($p in gci patches/*) {
    docker run -it --rm -v $PWD/logs:/logs -v $PWD/patches:/patches -v $PWD/scripts:/scripts graf-thesis /scripts/patch-and-run.sh $p.BaseName
}
