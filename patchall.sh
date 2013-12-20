#!/bin/bash

cd `dirname $0`
DSTDIR=$1

if [ -z "$DSTDIR" ]
then
    echo "Usage: $0 <sources dir>"
    exit 1
fi

grn=$(tput setaf 2) # Green
txtrst=$(tput sgr0) # Reset

# Traffic indicator patch
traffic/traffic.sh $DSTDIR

# WiFi Country patch
echo ""
echo "${grn}Applying WiFi Country patch${txtrst}"
cat allpatches/WiFi_Country.patch | patch -d $DSTDIR/frameworks/opt/telephony -p1 -N -r -

# Allowed to provide the name CM_BUILDTYPE
echo ""
echo "${grn}Allowed to provide the name CM_BUILDTYPE${txtrst}"
cat allpatches/CM_BUILDTYPE.patch | patch -d $DSTDIR/vendor/cm -p1 -N -r -

# initrc-ril
echo "${grn}Applying init.rc patch. Allow connecting pppd${txtrst}"
cat allpatches/initrc-ril.patch | patch -d $DSTDIR/system/core -p1 -N -r -

# linaro toolchain
echo ""
echo "${grn}Copy linaro${txtrst}"
cp -r linaro-4.7 $DSTDIR/prebuilts/gcc/linux-x86/arm/
echo "${grn}Apply linaro patch${txtrst}"
cat allpatches/linaro.patch | patch -d $DSTDIR/build -p1 -N -r -
