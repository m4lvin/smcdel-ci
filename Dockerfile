FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends graphviz poppler-utils dot2tex texlive-latex-base preview-latex-style texlive-pstricks
RUN apt-get install -y --no-install-recommends curl ca-certificates build-essential
RUN apt-get install -y g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg netbase
ENV STACK_ROOT="/stack-root"
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN stack update
RUN stack setup --resolver=lts-15.12
RUN git clone https://github.com/jrclogic/SMCDEL
RUN cd SMCDEL && stack build --only-dependencies
RUN cd SMCDEL && stack test  --only-dependencies --no-run-tests
RUN cd SMCDEL && stack bench --only-dependencies --no-run-benchmarks
RUN apt-get clean
RUN rm -rf SMCDEL
