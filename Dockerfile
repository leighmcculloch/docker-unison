FROM phusion/baseimage:0.9.16
CMD ["/sbin/my_init"]

MAINTAINER Leigh McCulloch

# Upload Unison for building
COPY unison-2.40.102.tar.gz /tmp/unison/
COPY unison-2.48.3.tar.gz /tmp/unison/

# Build and install Unison versions then cleanup
COPY unison-install.sh .
RUN sh -c "echo 'deb http://download.opensuse.org/repositories/home:/ocaml/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/ocaml.list" \
 && apt-get update -y \
 && apt-get install -y ocaml build-essential exuberant-ctags \
 && ./unison-install.sh \
 && apt-get purge -y ocaml build-essential exuberant-ctags \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Set default Unison version
ENV UNISON_VERSION=2.48.3

# Set working directory to be the home directory
WORKDIR /root

# Setup unison to run as a service
VOLUME /unison
COPY unison-run.sh /etc/service/unison/run
EXPOSE 5000
