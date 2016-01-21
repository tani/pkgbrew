#! /bin/sh

set -x

export PKGHOME="${PWD}/test"
export PKGBREW="${PWD}/bin/pkgbrew"

./bin/installer > installer.log
tail installer.log

export PATH="${PKGHOME}/bin:${PATH}"

pkgbrew search emacs
pkgbrew install misc/less
pkgbrew deinstall misc/less
pkgbrew clean-deps misc/less
pkgbrew clean misc/less
pkgbrew tap NetBSD/pkgsrc-wip > /dev/null
pkgbrew untap NetBSD/pkgsrc-wip > /dev/null
pkgbrew test misc/less


rm -rf "${PKGHOME}" installer.log
