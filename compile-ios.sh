#!/usr/bin/env arch -x86_64 bash

echo "Current shell architecture: $(uname -m)"

sh init-ios.sh || exit
sh init-ios-openssl.sh || exit
cd ios || exit

sh compile-openssl.sh clean || exit
sh compile-ffmpeg.sh clean || exit

sh compile-openssl.sh all || exit
sh compile-ffmpeg.sh all || exit
