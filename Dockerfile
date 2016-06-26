FROM phusion/baseimage:0.9.16
CMD ["/sbin/my_init"]

MAINTAINER Leigh McCulloch

# Upload Unison for building
COPY container /
ENV OCAML_MINOR_VERSION=4.02

# Build and install Unison versions then cleanup
RUN apt-get update -y \
 && curl -LO http://download.opensuse.org/repositories/home:ocaml/xUbuntu_14.04/Release.key \
 && apt-key add - < Release.key \
 && apt-get update -y \
 && dependencies-install.sh \
 && unison-install.sh \
 && apt-get purge -y ocaml ocaml-* camlp4 build-essential exuberant-ctags \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Set default Unison configuration
ENV UNISON_VERSION=2.48.3
ENV UNISON_WORKING_DIR=/unison

RUN unison-link.sh

# Set working directory to be the home directory
WORKDIR /root

# Setup unison to run as a service
VOLUME $UNISON_WORKING_DIR
EXPOSE 5000
