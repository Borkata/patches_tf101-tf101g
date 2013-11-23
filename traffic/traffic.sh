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
    echo "${grn}adding traffic.java${txtrst}"
    cp Traffic.java $DSTDIR/frameworks/base/packages/SystemUI/src/com/android/systemui/statusbar/policy

    echo ""
    echo "${grn}Applying traffic patches${txtrst}"
    echo "${grn}Settings:${txtrst}"
    cat Settings.patch | patch -d $DSTDIR/packages/apps/Settings -p1 -N -r -
    echo "${grn}Frameworks:${txtrst}"
    cat frameworks_base.patch | patch -d $DSTDIR/frameworks/base -p1 -N -r -

    echo "${grn}--== Done Traffic patch. ==--${txtrst}"
else
    echo ""
    echo "${red}Wrong distrib - $DISTR. Is not CyanogenMod 10.2. Skipping... ${txtrst}"
fi
