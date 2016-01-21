#! /bin/sh

set -ex

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"

./bin/installer > installer.log
tail installer.log

export PATH="${PKGHOME}/bin:${PATH}"

pkgbrew help
pkgbrew search emacs
pkgbrew install misc/less
pkgbrew deinstall misc/less
pkgbrew clean-depends misc/less
pkgbrew clean misc/less
pkgbrew update
pkgbrew tap NetBSD/pkgsrc-wip
pkgbrew update
pkgbrew untap NetBSD/pkgsrc-wip
pkgbrew test misc/less
pkgbrew version

rm -rf "${PKGHOME}" installer.log
