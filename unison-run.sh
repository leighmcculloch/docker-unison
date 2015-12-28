#!/bin/sh
export HOME=/root
cd $UNISON_DIR
if [ -f /bin/unison-$UNISON_VERSION-fsmonitor ]; then
  ln -s -f /bin/unison-$UNISON_VERSION-fsmonitor /bin/unison-fsmonitor
fi
exec unison-$UNISON_VERSION -socket 5000 >>/var/log/unison.log 2>&1
