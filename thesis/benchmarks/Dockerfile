FROM haskell:8.0.2
MAINTAINER Sebastian Graf <sgraf1337@gmail.com>

ENV PATH /root/.cabal/bin:$PATH

RUN cabal update
RUN cabal install html regex-compat

RUN apt-get update
RUN apt-get install --yes git
RUN apt-get install --yes valgrind
RUN apt-get install --yes build-essential
RUN apt-get install --yes autoconf
RUN apt-get install --yes time
RUN apt-get install --yes libncurses5-dev libffi-dev libgmp-dev

RUN git clone --recursive git://git.haskell.org/ghc.git
RUN git -C ghc/ checkout 0cee252
RUN git -C ghc/ submodule update --init
