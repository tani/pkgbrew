# pkgbrew
[![Build Status](https://travis-ci.org/ta2gch/pkgbrew.svg?branch=master)](https://travis-ci.org/ta2gch/pkgbrew)

non-root package manager

## Usage

### Install a package

```
$ pkgbrew -i editors/emacs-nox11
```

### Uninstall a package

```
$ pkgbrew -d editors/emacs-nox11
```

### Upgrade a package

```
$ pkgbrew -r editors/emacs-nox11
```

### Show build parameters

```
$ pkgbrew -O editors/emacs24
```


### Show build dependencies

```
$ pkgbrew -D editors/emacs24
```

### Search a package

```
$ pkgbrew -s editors/emacs
```

### Show Usage

```
$ pkgbrew -h
```

## Installation

```
$ go get github.com/ta2gch/pkgbrew
$ MAKE_JOBS=4 CC=gcc pkgbrew --init
```

binary version is comming soon.

## Supported platforms

- NetBSD
- Solaris
- Linux (test environment)
- Darwin(Mac OS X) (Travis CI)
- FreeBSD

(see also pkgsrc.org)

## Software requirements

- gcc (and libstdc++)
- libncurses-devel
- zlib and zlib-devel

### Debian/Ubuntu

```
$ sudo apt-get install build-essential
```

### Mac OSX

Set the CC variable in the environment before the script the starts. (`export CC=clang`)

## Author

TANIGUCHI Masaya

## Copyright

Copyright(c) 2016,2017 TANIGUCHI Masaya (ta2gch@gmail.com)

## License

BSD License (2 clause)