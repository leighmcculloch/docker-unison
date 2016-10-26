build:
	sed -e "s/\$${UNISON_VERSION}/2.48.4/"   -e "s/\$${OCAML_VERSION}/4.03/" Dockerfile > Dockerfile-unison2.48.4-ocaml4.03
	sed -e "s/\$${UNISON_VERSION}/2.48.3/"   -e "s/\$${OCAML_VERSION}/4.02/" Dockerfile > Dockerfile-unison2.48.3-ocaml4.02
	sed -e "s/\$${UNISON_VERSION}/2.48.3/"   -e "s/\$${OCAML_VERSION}/4.01/" Dockerfile > Dockerfile-unison2.48.3-ocaml4.01
	sed -e "s/\$${UNISON_VERSION}/2.40.102/" -e "s/\$${OCAML_VERSION}/4.02/" Dockerfile > Dockerfile-unison2.40.102-ocaml4.02
	sed -e "s/\$${UNISON_VERSION}/2.40.102/" -e "s/\$${OCAML_VERSION}/4.01/" Dockerfile > Dockerfile-unison2.40.102-ocaml4.01
