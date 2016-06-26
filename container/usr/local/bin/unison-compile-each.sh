#!/bin/sh

for OCAML_VERSION in '4.01' '4.02'
do
  dependencies-install.sh ${OCAML_VERSION}
  unison-install.sh ${OCAML_VERSION}
  dependencies-purge.sh
done