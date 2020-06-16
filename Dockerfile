FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends graphviz poppler-utils dot2tex texlive-latex-base preview-latex-style texlive-pstricks curl ca-certificates build-essential g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase && apt-get clean
ENV STACK_ROOT="/stack-root"
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN stack update
ARG lts=16.1
RUN stack setup --resolver=lts-$lts
RUN git clone https://github.com/jrclogic/SMCDEL \
    && cd SMCDEL \
    && stack build --resolver=lts-$lts --only-dependencies \
    && stack test  --resolver=lts-$lts --only-dependencies --no-run-tests \
    && stack bench --resolver=lts-$lts --only-dependencies --no-run-benchmarks \
    && rm -rf SMCDEL
