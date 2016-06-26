#!/bin/sh

apt-get purge -y ocaml ocaml-* camlp4 build-essential exuberant-ctags \
 && apt-get clean autoclean \
 && apt-get autoremove -y