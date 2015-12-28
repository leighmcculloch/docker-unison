#!/bin/sh

cd /tmp/unison
for UNISON_TAR_GZ in `find *.tar.gz`
do
  cd /tmp/unison
  tar -zxvf $UNISON_TAR_GZ
  UNISON_RELEASE=${UNISON_TAR_GZ%.tar.gz}
  cd $UNISON_RELEASE
  make UISTYLE=text NATIVE=true
  cp unison /bin/$UNISON_RELEASE
  if [ -f unison-fsmonitor ]; then
    cp unison-fsmonitor /bin/$UNISON_RELEASE-fsmonitor
  fi
done
