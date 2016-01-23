#! /bin/sh

set -ex

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
pkgbrew tap ta2gch/pkgsrc-goodies
pkgbrew update
pkgbrew untap ta2gch/pkgsrc-goodies
pkgbrew test misc/less
pkgbrew version

rm -rf "${PKGHOME}" installer.log
