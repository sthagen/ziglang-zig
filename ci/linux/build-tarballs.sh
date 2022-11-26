#!/bin/sh

apt-get install ninja-build

set -x
set -e

ZIGDIR="$(pwd)"
REL_SRC_BUILD="$ZIGDIR/build-release"
cd ../..
WORKDIR="$(pwd)"
ARCH="$(uname -m)"
TARGET="$ARCH-linux-musl"
MCPU="baseline"

git clone https://github.com/ziglang/zig-bootstrap
BOOTSTRAP_SRC="$WORKDIR/zig-bootstrap"
TARBALLS_DIR="$WORKDIR/tarballs"

cd "$BOOTSTRAP_SRC"
rm -rf zig
cp -r "$ZIGDIR" ./
sed -i "/^ZIG_VERSION=\".*\"\$/c\\ZIG_VERSION=\"$ZIG_VERSION\"" build

# NOTE: Debian's cmake (3.14.4) is too old for zig-bootstrap.
CMAKE_GENERATOR=Ninja ./build x86_64-linux-musl baseline
CMAKE_GENERATOR=Ninja ./build x86_64-macos-none baseline
CMAKE_GENERATOR=Ninja ./build x86_64-windows-gnu baseline
CMAKE_GENERATOR=Ninja ./build aarch64-linux-musl baseline
CMAKE_GENERATOR=Ninja ./build aarch64-macos-none apple_a14
# CMAKE_GENERATOR=Ninja ./build aarch64-windows-gnu baseline
# CMAKE_GENERATOR=Ninja ./build x86-linux-musl baseline
# CMAKE_GENERATOR=Ninja ./build x86-windows-gnu baseline
# CMAKE_GENERATOR=Ninja ./build arm-linux-musleabihf generic+v7a
# CMAKE_GENERATOR=Ninja ./build riscv64-linux-musl baseline

ZIG="$BOOTSTRAP_SRC/out/host/bin/zig"

mkdir "$TARBALLS_DIR"
cd "$TARBALLS_DIR"

cp -r "$ZIGDIR" ./
rm -rf \
  "zig/.github" \
  "zig/.gitignore" \
  "zig/.git" \
  "zig/ci" \
  "zig/CODE_OF_CONDUCT.md" \
  "zig/CONTRIBUTING.md" \
  "zig/.builds" \
  "zig/build" \
  "zig/build-release" \
  "zig/build-debug" \
  "zig/zig-cache"
mv zig "zig-$ZIG_VERSION"
tar cfJ "zig-$ZIG_VERSION.tar.xz" "zig-$ZIG_VERSION"

cd "$BOOTSTRAP_SRC"
"$ZIG" build --build-file zig/build.zig docs
LANGREF_HTML="$BOOTSTRAP_SRC/zig/zig-cache/langref.html"

# Look for HTML errors.
tidy --drop-empty-elements no -qe "$LANGREF_HTML"

cd "$TARBALLS_DIR"

cp -r $BOOTSTRAP_SRC/out/zig-x86_64-linux-musl-baseline zig-linux-x86_64-$ZIG_VERSION/
cp -r $BOOTSTRAP_SRC/out/zig-x86_64-macos-none-baseline zig-macos-x86_64-$ZIG_VERSION/
cp -r $BOOTSTRAP_SRC/out/zig-x86_64-windows-gnu-baseline zig-windows-x86_64-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-x86_64-freebsd-gnu-baseline zig-freebsd-x86_64-$ZIG_VERSION/
cp -r $BOOTSTRAP_SRC/out/zig-aarch64-linux-musl-baseline zig-linux-aarch64-$ZIG_VERSION/
cp -r $BOOTSTRAP_SRC/out/zig-aarch64-macos-none-apple_a14 zig-macos-aarch64-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-aarch64-windows-gnu-baseline zig-windows-aarch64-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-x86-linux-musl-baseline zig-linux-x86-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-x86-windows-gnu-baseline zig-windows-x86-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-arm-linux-musleabihf-generic+v7a zig-linux-armv7a-$ZIG_VERSION/
#cp -r $BOOTSTRAP_SRC/out/zig-riscv64-linux-musl-baseline zig-linux-riscv64-$ZIG_VERSION/

mv zig-linux-x86_64-$ZIG_VERSION/{bin/,}zig
mv zig-macos-x86_64-$ZIG_VERSION/{bin/,}zig
mv zig-windows-x86_64-$ZIG_VERSION/{bin/,}zig.exe
#mv zig-freebsd-x86_64-$ZIG_VERSION/{bin/,}zig
mv zig-linux-aarch64-$ZIG_VERSION/{bin/,}zig
mv zig-macos-aarch64-$ZIG_VERSION/{bin/,}zig
#mv zig-windows-aarch64-$ZIG_VERSION/{bin/,}zig.exe
#mv zig-linux-x86-$ZIG_VERSION/{bin/,}zig
#mv zig-windows-x86-$ZIG_VERSION/{bin/,}zig.exe
#mv zig-linux-armv7a-$ZIG_VERSION/{bin/,}zig
#mv zig-linux-riscv64-$ZIG_VERSION/{bin/,}zig

mv zig-linux-x86_64-$ZIG_VERSION/{lib,lib2}
mv zig-macos-x86_64-$ZIG_VERSION/{lib,lib2}
mv zig-windows-x86_64-$ZIG_VERSION/{lib,lib2}
#mv zig-freebsd-x86_64-$ZIG_VERSION/{lib,lib2}
mv zig-linux-aarch64-$ZIG_VERSION/{lib,lib2}
mv zig-macos-aarch64-$ZIG_VERSION/{lib,lib2}
#mv zig-windows-aarch64-$ZIG_VERSION/{lib,lib2}
#mv zig-linux-x86-$ZIG_VERSION/{lib,lib2}
#mv zig-windows-x86-$ZIG_VERSION/{lib,lib2}
#mv zig-linux-armv7a-$ZIG_VERSION/{lib,lib2}
#mv zig-linux-riscv64-$ZIG_VERSION/{lib,lib2}

mv zig-linux-x86_64-$ZIG_VERSION/{lib2/zig,lib}
mv zig-macos-x86_64-$ZIG_VERSION/{lib2/zig,lib}
mv zig-windows-x86_64-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-freebsd-x86_64-$ZIG_VERSION/{lib2/zig,lib}
mv zig-linux-aarch64-$ZIG_VERSION/{lib2/zig,lib}
mv zig-macos-aarch64-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-windows-aarch64-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-linux-x86-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-windows-x86-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-linux-armv7a-$ZIG_VERSION/{lib2/zig,lib}
#mv zig-linux-riscv64-$ZIG_VERSION/{lib2/zig,lib}

rmdir zig-linux-x86_64-$ZIG_VERSION/{bin,lib2}
rmdir zig-macos-x86_64-$ZIG_VERSION/{bin,lib2}
rmdir zig-windows-x86_64-$ZIG_VERSION/{bin,lib2}
#rmdir zig-freebsd-x86_64-$ZIG_VERSION/{bin,lib2}
rmdir zig-linux-aarch64-$ZIG_VERSION/{bin,lib2}
rmdir zig-macos-aarch64-$ZIG_VERSION/{bin,lib2}
#rmdir zig-windows-aarch64-$ZIG_VERSION/{bin,lib2}
#rmdir zig-linux-x86-$ZIG_VERSION/{bin,lib2}
#rmdir zig-windows-x86-$ZIG_VERSION/{bin,lib2}
#rmdir zig-linux-armv7a-$ZIG_VERSION/{bin,lib2}
#rmdir zig-linux-riscv64-$ZIG_VERSION/{bin,lib2}

cp $REL_SRC_BUILD/../LICENSE zig-linux-x86_64-$ZIG_VERSION/
cp $REL_SRC_BUILD/../LICENSE zig-macos-x86_64-$ZIG_VERSION/
cp $REL_SRC_BUILD/../LICENSE zig-windows-x86_64-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-freebsd-x86_64-$ZIG_VERSION/
cp $REL_SRC_BUILD/../LICENSE zig-linux-aarch64-$ZIG_VERSION/
cp $REL_SRC_BUILD/../LICENSE zig-macos-aarch64-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-windows-aarch64-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-linux-x86-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-windows-x86-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-linux-armv7a-$ZIG_VERSION/
#cp $REL_SRC_BUILD/../LICENSE zig-linux-riscv64-$ZIG_VERSION/

mkdir zig-linux-x86_64-$ZIG_VERSION/doc/
mkdir zig-macos-x86_64-$ZIG_VERSION/doc/
mkdir zig-windows-x86_64-$ZIG_VERSION/doc/
#mkdir zig-freebsd-x86_64-$ZIG_VERSION/doc/
mkdir zig-linux-aarch64-$ZIG_VERSION/doc/
mkdir zig-macos-aarch64-$ZIG_VERSION/doc/
#mkdir zig-windows-aarch64-$ZIG_VERSION/doc/
#mkdir zig-linux-x86-$ZIG_VERSION/doc/
#mkdir zig-windows-x86-$ZIG_VERSION/doc/
#mkdir zig-linux-armv7a-$ZIG_VERSION/doc/
#mkdir zig-linux-riscv64-$ZIG_VERSION/doc/

cd $REL_SRC_BUILD
stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-linux-x86_64 -target x86_64-linux-musl -fno-emit-bin --zig-lib-dir ../lib
stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-windows-x86_64 -target x86_64-windows-gnu -fno-emit-bin --zig-lib-dir ../lib
stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-macos-x86_64 -target x86_64-macos -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-freebsd-x86_64 -target x86_64-freebsd -fno-emit-bin --zig-lib-dir ../lib
stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-linux-aarch64 -target aarch64-linux-musl -fno-emit-bin --zig-lib-dir ../lib
stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-macos-aarch64 -target aarch64-macos -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-windows-aarch64 -target aarch64-windows-gnu -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-linux-x86 -target x86-linux-musl -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-windows-x86 -target x86-windows-gnu -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-linux-armv7a -target arm-linux-musl -mcpu=generic+v7a -fno-emit-bin --zig-lib-dir ../lib
#stage3-release/bin/zig test ../lib/std/std.zig -femit-docs=doc-linux-riscv64 -target riscv64-linux-musl -fno-emit-bin --zig-lib-dir ../lib

cd "$TARBALLS_DIR"
cp -r $REL_SRC_BUILD/doc-linux-x86_64 zig-linux-x86_64-$ZIG_VERSION/doc/std
cp -r $REL_SRC_BUILD/doc-macos-x86_64 zig-macos-x86_64-$ZIG_VERSION/doc/std
cp -r $REL_SRC_BUILD/doc-windows-x86_64 zig-windows-x86_64-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-freebsd-x86_64 zig-freebsd-x86_64-$ZIG_VERSION/doc/std
cp -r $REL_SRC_BUILD/doc-linux-aarch64 zig-linux-aarch64-$ZIG_VERSION/doc/std
cp -r $REL_SRC_BUILD/doc-macos-aarch64 zig-macos-aarch64-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-windows-aarch64 zig-windows-aarch64-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-linux-x86 zig-linux-x86-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-windows-x86 zig-windows-x86-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-linux-armv7a zig-linux-armv7a-$ZIG_VERSION/doc/std
#cp -r $REL_SRC_BUILD/doc-linux-riscv64 zig-linux-riscv64-$ZIG_VERSION/doc/std

cp $LANGREF_HTML zig-linux-x86_64-$ZIG_VERSION/doc/
cp $LANGREF_HTML zig-macos-x86_64-$ZIG_VERSION/doc/
cp $LANGREF_HTML zig-windows-x86_64-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-freebsd-x86_64-$ZIG_VERSION/doc/
cp $LANGREF_HTML zig-linux-aarch64-$ZIG_VERSION/doc/
cp $LANGREF_HTML zig-macos-aarch64-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-windows-aarch64-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-linux-x86-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-windows-x86-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-linux-armv7a-$ZIG_VERSION/doc/
#cp $LANGREF_HTML zig-linux-riscv64-$ZIG_VERSION/doc/

tar cJf zig-linux-x86_64-$ZIG_VERSION.tar.xz zig-linux-x86_64-$ZIG_VERSION/
tar cJf zig-macos-x86_64-$ZIG_VERSION.tar.xz zig-macos-x86_64-$ZIG_VERSION/
7z a zig-windows-x86_64-$ZIG_VERSION.zip zig-windows-x86_64-$ZIG_VERSION/
#tar cJf zig-freebsd-x86_64-$ZIG_VERSION.tar.xz zig-freebsd-x86_64-$ZIG_VERSION/
tar cJf zig-linux-aarch64-$ZIG_VERSION.tar.xz zig-linux-aarch64-$ZIG_VERSION/
tar cJf zig-macos-aarch64-$ZIG_VERSION.tar.xz zig-macos-aarch64-$ZIG_VERSION/
#7z a zig-windows-aarch64-$ZIG_VERSION.zip zig-windows-aarch64-$ZIG_VERSION/
#tar cJf zig-linux-x86-$ZIG_VERSION.tar.xz zig-linux-x86-$ZIG_VERSION/
#7z a zig-windows-x86-$ZIG_VERSION.zip zig-windows-x86-$ZIG_VERSION/
#tar cJf zig-linux-armv7a-$ZIG_VERSION.tar.xz zig-linux-armv7a-$ZIG_VERSION/
#tar cJf zig-linux-riscv64-$ZIG_VERSION.tar.xz zig-linux-riscv64-$ZIG_VERSION/

s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-bootstrap-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-linux-x86_64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-macos-x86_64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-freebsd-x86_64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-windows-x86_64-$ZIG_VERSION.zip s3://ziglang.org/builds/$ZIG_VERSION/
s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-linux-aarch64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-macos-aarch64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-windows-aarch64-$ZIG_VERSION.zip s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-linux-x86-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-windows-x86-$ZIG_VERSION.zip s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-linux-armv7a-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/
#s3cmd put -P --add-header="cache-control: public, max-age=31536000, immutable" zig-linux-riscv64-$ZIG_VERSION.tar.xz s3://ziglang.org/builds/$ZIG_VERSION/

export SRC_TARBALL="zig-$ZIG_VERSION.tar.xz"
export SRC_SHASUM=$(sha256sum "zig-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)
export SRC_BYTESIZE=$(wc -c < "zig-$ZIG_VERSION.tar.xz")

export X86_64_WINDOWS_TARBALL="zig-windows-x86_64-$ZIG_VERSION.zip"
export X86_64_WINDOWS_BYTESIZE=$(wc -c < "zig-windows-x86_64-$ZIG_VERSION.zip")
export X86_64_WINDOWS_SHASUM="$(sha256sum "zig-windows-x86_64-$ZIG_VERSION.zip" | cut '-d ' -f1)"

export AARCH64_MACOS_TARBALL="zig-macos-aarch64-$ZIG_VERSION.tar.xz"
export AARCH64_MACOS_BYTESIZE=$(wc -c < "zig-macos-aarch64-$ZIG_VERSION.tar.xz")
export AARCH64_MACOS_SHASUM="$(sha256sum "zig-macos-aarch64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

export X86_64_MACOS_TARBALL="zig-macos-x86_64-$ZIG_VERSION.tar.xz"
export X86_64_MACOS_BYTESIZE=$(wc -c < "zig-macos-x86_64-$ZIG_VERSION.tar.xz")
export X86_64_MACOS_SHASUM="$(sha256sum "zig-macos-x86_64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

export X86_64_LINUX_TARBALL="zig-linux-x86_64-$ZIG_VERSION.tar.xz"
export X86_64_LINUX_BYTESIZE=$(wc -c < "zig-linux-x86_64-$ZIG_VERSION.tar.xz")
export X86_64_LINUX_SHASUM="$(sha256sum "zig-linux-x86_64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

export AARCH64_LINUX_TARBALL="zig-linux-aarch64-$ZIG_VERSION.tar.xz"
export AARCH64_LINUX_BYTESIZE=$(wc -c < "zig-linux-aarch64-$ZIG_VERSION.tar.xz")
export AARCH64_LINUX_SHASUM="$(sha256sum "zig-linux-aarch64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

#export X86_64_FREEBSD_TARBALL="zig-freebsd-x86_64-$ZIG_VERSION.tar.xz"
#export X86_64_FREEBSD_BYTESIZE=$(wc -c < "zig-freebsd-x86_64-$ZIG_VERSION.tar.xz")
#export X86_64_FREEBSD_SHASUM="$(sha256sum "zig-freebsd-x86_64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

#export X86_64_NETBSD_TARBALL="zig-netbsd-x86_64-$ZIG_VERSION.tar.xz"
#export X86_64_NETBSD_BYTESIZE=$(wc -c < "zig-netbsd-x86_64-$ZIG_VERSION.tar.xz")
#export X86_64_NETBSD_SHASUM="$(sha256sum "zig-netbsd-x86_64-$ZIG_VERSION.tar.xz" | cut '-d ' -f1)"

export MASTER_DATE="$(date +%Y-%m-%d)"
export MASTER_VERSION="$ZIG_VERSION"

# Create index.json and update the website repo.
cd "$ZIGDIR/ci"
"$ZIG" run update-download-page.zig
mv out "$TARBALLS_DIR/out"

cd "$WORKDIR"
git clone --depth=1 git@github.com:ziglang/www.ziglang.org.git
cd www.ziglang.org

# This is the user when pushing to the website repo.
git config user.email "ziggy@ziglang.org"
git config user.name "Ziggy"

cp "$TARBALLS_DIR/out/index.json" data/releases.json
git add data/releases.json
git commit -m "CI: update releases"
git push origin master

# Update autodocs and langref directly to S3 in order to prevent the
# www.ziglang.org git repo from growing too big.

# Please do not edit this script to pre-compress the artifacts before they hit
# S3. This prevents the website from working on browsers that do not support gzip
# encoding. Cloudfront will automatically compress files if they are less than
# 9.5 MiB, and the client advertises itself as capable of decompressing.
# The data.js file is currently 16 MiB. In order to fix this problem, we need to do
# one of the following things:
# * Reduce the size of data.js to less than 9.5 MiB.
# * Figure out how to adjust the Cloudfront settings to increase the max size for
#   auto-compressed objects.
# * Migrate to fastly.
DOCDIR="$TARBALLS_DIR/zig-linux-aarch64-$ZIG_VERSION/doc"
s3cmd put -P --no-mime-magic \
  --add-header="Cache-Control: max-age=0, must-revalidate" \
  "$LANGREF_HTML" s3://ziglang.org/documentation/master/index.html

s3cmd put -P --no-mime-magic \
  --add-header="Cache-Control: max-age=0, must-revalidate" \
  "$DOCDIR/std/index.html" s3://ziglang.org/documentation/master/std/index.html

s3cmd put -P --no-mime-magic \
  --add-header="Cache-Control: max-age=0, must-revalidate" \
  "$DOCDIR/std/main.js" s3://ziglang.org/documentation/master/std/main.js

s3cmd put -P --no-mime-magic \
  --add-header="Cache-Control: max-age=0, must-revalidate" \
  "$DOCDIR/std/data.js" s3://ziglang.org/documentation/master/std/data.js

s3cmd put -P --no-mime-magic --recursive \
  --add-header="Cache-Control: max-age=0, must-revalidate" \
  -m "text/html" \
  "$DOCDIR/std/src/" s3://ziglang.org/documentation/master/std/src/
