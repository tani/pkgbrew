#! /bin/sh

PKGHOME=./test
PKGBREW=./bin/pkgbrew

. ./bin/installer > installer.log
tail installer.log

rm -rf "${PKGHOME}" installer.log
