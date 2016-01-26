#! /bin/sh

set -xe

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"

./bin/installer

export PATH="${PKGHOME}/bin:${PATH}"

pkgbrew help
pkgbrew search emacs
pkgbrew install misc/less
pkgbrew deinstall misc/less
pkgbrew clean-depends misc/less
pkgbrew clean misc/less
pkgbrew update
pkgbrew tap ta2gch/collection
pkgbrew install ta2gch/collection/sbcl-x64-linux
pkgbrew update
pkgbrew untap ta2gch/collection
pkgbrew test misc/less
pkgbrew version

rm -rf "${PKGHOME}"
