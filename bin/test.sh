#! /bin/sh

set -xe

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"
export PATH="${PKGHOME}/bin:${PATH}"

./bin/installer--no-check-certificate--with-clang

TARGET="benchmarks/fib"

pkgbrew help
pkgbrew search emacs
pkgbrew install "${TARGET}"
pkgbrew deinstall "${TARGET}"
pkgbrew clean-depends "${TARGET}"
pkgbrew clean "${TARGET}"
pkgbrew update
pkgbrew tap ta2gch/collection
pkgbrew update
pkgbrew untap ta2gch/collection
pkgbrew test "${TARGET}"
pkgbrew version

rm -rf "${PKGHOME}"
