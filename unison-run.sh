#!/bin/sh
export HOME=/root
cd /unison
exec unison-$UNISON_VERSION -socket 5000 >>/var/log/unison.log 2>&1
