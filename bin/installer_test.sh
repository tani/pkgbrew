#! /bin/sh

set -xe

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"
export PATH="${PKGHOME}/bin:${PATH}"
export CC="clang"
export MAKE_JOBS=8

./bin/installer

pkgbrew install benchmarks/fib
fib
rm -rf ${PKGHOME}
