FROM phusion/baseimage:0.9.16
CMD ["/sbin/my_init"]

MAINTAINER Leigh McCulloch

# Build and install Unison
RUN apt-get update -y
RUN apt-get install -y ocaml build-essential exuberant-ctags

## Version 2.40.102
ADD unison-2.40.102.tar.gz /tmp
WORKDIR /tmp/unison-2.40.102
RUN make UISTYLE=text && cp unison /bin/unison-2.40.102

## Version 2.48.3
ADD unison-2.48.3.tar.gz /tmp
WORKDIR /tmp/unison-2.48.3
RUN make UISTYLE=text && cp unison /bin/unison-2.48.3

# Clean install artifacts
RUN apt-get purge -y ocaml build-essential exuberant-ctags \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Set default Unison version and port
ENV UNISON_VERSION=2.48.3

# Set working directory to be the home directory
WORKDIR /root

# Setup unison to run as a service
VOLUME /unison
RUN mkdir /etc/service/unison
ADD ./unison-run.sh /etc/service/unison/run
RUN chmod +x /etc/service/unison/run
EXPOSE 5000
