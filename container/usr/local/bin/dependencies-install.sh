#!/bin/sh

apt-get install -y\
ocaml=${OCAML_VERSION}.*\
camlp4=${OCAML_VERSION}.*\
ocaml-nox=${OCAML_VERSION}.*\
ocaml-base=${OCAML_VERSION}.*\
ocaml-interp=${OCAML_VERSION}.*\
ocaml-base-nox=${OCAML_VERSION}.*\
ocaml-compiler-libs=${OCAML_VERSION}.*

apt-get install -y build-essential exuberant-ctags
