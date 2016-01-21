#! /bin/sh

set -x

PKGHOME="${PWD}/test"
PKGBREW="${PWD}/bin/pkgbrew"

. ./bin/installer > installer.log
tail installer.log

export PATH="${PKGHOME}/bin:${PATH}"

pkgbrew install misc/less
pkgbrew deinstall misc/less
pkgbrew clean-deps misc/less
pkgbrew clean misc/less
pkgbrew tap NetBSD/pkgsrc-wip > /dev/null
pkgbrew untap NetBSD/pkgsrc-wip > /dev/null
pkgbrew test misc/less
pkgbrew search emacs

rm -rf "${PKGHOME}" installer.log
