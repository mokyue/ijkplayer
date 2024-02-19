#!/usr/bin/env arch -x86_64 bash

echo "Current shell architecture: $(uname -m)"

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_NDK=$ANDROID_HOME/ndk/android-ndk-r12b
export NDK_HOST_AWK=/usr/bin/awk
ACT_ARCHS_ALL="armv7a arm64 x86 x86_64"

cd config || exit
rm -rf module.sh
ln -s module-lite.sh module.sh

cd .. || exit
sh init-android.sh || exit
sh init-android-exo.sh || exit
sh init-android-j4a.sh || exit
sh init-android-openssl.sh || exit
sh init-android-prof.sh || exit

cd android/contrib || exit
sh compile-openssl.sh clean || exit
for ARCH in $ACT_ARCHS_ALL
do
    sh compile-openssl.sh "$ARCH" || exit
done

sh compile-ffmpeg.sh clean || exit
for ARCH in $ACT_ARCHS_ALL
do
    sh compile-ffmpeg.sh "$ARCH" || exit
done

cd .. || exit
sh compile-ijk.sh clean || exit
for ARCH in $ACT_ARCHS_ALL
do
    sh compile-ijk.sh "$ARCH" || exit
done
