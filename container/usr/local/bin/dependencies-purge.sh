#!/bin/sh

apt-get purge -y \
 ocaml \
 ocaml-nox \
 ocaml-base \
 ocaml-interp \
 ocaml-base-nox \
 ocaml-compiler-libs \
 camlp4 \
 build-essential \
 exuberant-ctags \
 && apt-get clean autoclean \
 && apt-get autoremove -y
 