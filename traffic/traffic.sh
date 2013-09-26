#!/bin/bash

cd `dirname $0`
DSTDIR=$1

red=$(tput setaf 1) # Red
grn=$(tput setaf 2) # Green
txtrst=$(tput sgr0) # Reset

if [ -z "$DSTDIR" ]
then
    echo "Usage: $0 <sources dir>"
    exit 1
fi

DISTR=`head -1 $DSTDIR/.repo/manifests/README.*`

if [ "$DISTR" == "CyanogenMod" ]; then
    echo ""
    echo "${grn}--== Traffic patch. Allows you to see the speed of data transmission ==--${txtrst}"
    echo ""
    echo "${grn}adding traffic.java${txtrst}"
    cp  Traffic.java $DSTDIR/frameworks/base/packages/SystemUI/src/com/android/systemui/statusbar/policy

    echo ""
    echo "${grn}Applying  patch${txtrst}"
    cat traffic.patch | patch -d $DSTDIR -p1 -N -r -

    echo "${grn}Done${txtrst}"
else
    echo ""
    echo "${red}Wrong distrib - $DISTR. Is not CyanogenMod 10.2. Skipping... ${txtrst}"
fi
