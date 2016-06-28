#!/bin/sh

UNISON_RELEASE=unison-${UNISON_VERSION}
cd /tmp/unison
tar -zxvf ${UNISON_RELEASE}.tar.gz
cd ${UNISON_RELEASE}
make UISTYLE=text
cp unison /bin/
if [ -f 'unison-fsmonitor' ]; then
  cp unison-fsmonitor /bin/
fi
