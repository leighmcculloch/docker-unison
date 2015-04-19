#!/bin/sh

cd /tmp/unison
for UNISON_TAR_GZ in `find *.tar.gz`
do
  cd /tmp/unison
  tar -zxvf $UNISON_TAR_GZ
  UNISON_RELEASE=${UNISON_TAR_GZ%.tar.gz}
  cd $UNISON_RELEASE
  make UISTYLE=text
  cp unison /bin/$UNISON_RELEASE
done
