#!/bin/bash

cd `dirname $0`
DSTDIR=$1

if [ -z "$DSTDIR" ]
then
    echo "Usage: $0 <sources dir>"
    exit 1
fi

# Traffic indicator patch
traffic/traffic.sh $DSTDIR

# WiFi Country patch
echo ""
echo "${grn}Applying WiFi Country patch${txtrst}"
cat allpatches/WiFi_Country.patch | patch -d $DSTDIR/frameworks/opt/telephony -p1 -N -r -
