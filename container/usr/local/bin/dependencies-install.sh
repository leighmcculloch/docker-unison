#!/bin/sh

case "${OCAML_MINOR_VERSION}" in
  '4.02')
    apt-get install -y ocaml
    ;;
  *)
    apt-get install -y\
    ocaml=${OCAML_MINOR_VERSION}.*\
    camlp4=${OCAML_MINOR_VERSION}.*\
    ocaml-nox=${OCAML_MINOR_VERSION}.*\
    ocaml-base=${OCAML_MINOR_VERSION}.*\
    ocaml-interp=${OCAML_MINOR_VERSION}.*\
    ocaml-base-nox=${OCAML_MINOR_VERSION}.*\
    ocaml-compiler-libs=${OCAML_MINOR_VERSION}.*\
    ;;
esac

apt-get install -y build-essential exuberant-ctags
