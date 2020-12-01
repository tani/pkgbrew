#! /bin/sh

set -xe

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"
export PATH="${PKGHOME}/bin:${PATH}"

./bin/installer

TARGET="benchmarks/fib"

pkgbrew help
pkgbrew search emacs
pkgbrew install "${TARGET}"
pkgbrew deinstall "${TARGET}"
pkgbrew clean-depends "${TARGET}"
pkgbrew clean "${TARGET}"
pkgbrew test "${TARGET}"
pkgbrew version

rm -rf "${PKGHOME}"
