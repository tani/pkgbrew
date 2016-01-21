#! /bin/sh

PKGHOME="${PWD}/test"
PKGBREW="${PWD}/bin/pkgbrew"

. ./bin/installer > installer.log
tail installer.log

rm -rf "${PKGHOME}" installer.log
