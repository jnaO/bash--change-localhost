#!/bin/bash

# Start processing options at index 1.
OPTIND=1

WEBROOT=`pwd`'/'$1
# ALTROOT=${1:-$WEBROOT}

rm ~/Sites/localhost
ln -s $WEBROOT ~/Sites/localhost