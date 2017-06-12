#!/bin/bash

if [ -z "$STRATAGUS" ]; then
    echo "You must tell me where the stratagus binary is located by setting the STRATAGUS variable!"
    exit 1
fi

STRATAGUS="$(cd "$(dirname "$STRATAGUS")" && pwd -P)/$(basename $STRATAGUS)"

cd "`dirname "$0"`"

# Create app bundle structure
rm -rf War1gus.app
mkdir -p War1gus.app/Contents/Resources
mkdir -p War1gus.app/Contents/MacOS
mkdir -p War1gus.app/Contents/libs

# Copy launchscript and info.plist
cp Info.plist War1gus.app/Contents/

# Generate icons
mkdir war1gus.iconset
sips -z 16 16     ../war1gus.png --out war1gus.iconset/icon_16x16.png
sips -z 32 32     ../war1gus.png --out war1gus.iconset/icon_16x16@2x.png
sips -z 32 32     ../war1gus.png --out war1gus.iconset/icon_32x32.png
sips -z 64 64     ../war1gus.png --out war1gus.iconset/icon_32x32@2x.png
sips -z 128 128   ../war1gus.png --out war1gus.iconset/icon_128x128.png
sips -z 256 256   ../war1gus.png --out war1gus.iconset/icon_128x128@2x.png
sips -z 256 256   ../war1gus.png --out war1gus.iconset/icon_256x256.png
sips -z 512 512   ../war1gus.png --out war1gus.iconset/icon_256x256@2x.png
sips -z 512 512   ../war1gus.png --out war1gus.iconset/icon_512x512.png
sips -z 1024 1024   ../war1gus.png --out war1gus.iconset/icon_512x512@2x.png
iconutil -c icns war1gus.iconset
rm -R war1gus.iconset
mv war1gus.icns War1gus.app/Contents/Resources/

# Bundle resources
cp -R ../campaigns ../contrib ../maps ../scripts War1gus.app/Contents/Resources/

# Bundle binaries and their dependencies
rm -rf macdylibbundler
git clone https://github.com/auriamg/macdylibbundler
cd macdylibbundler
make
cd ..

cp ../build/war1tool War1gus.app/Contents/MacOS/
cp ../build/war1gus War1gus.app/Contents/MacOS/
cp "$STRATAGUS" War1gus.app/Contents/MacOS/stratagus
cp "$(dirname "$STRATAGUS")"/../libs/* War1gus.app/Contents/libs/

macdylibbundler/dylibbundler -cd -of -b -x ./War1gus.app/Contents/MacOS/war1tool -d ./War1gus.app/Contents/libs/
macdylibbundler/dylibbundler -cd -of -b -x ./War1gus.app/Contents/MacOS/war1gus -d ./War1gus.app/Contents/libs/
