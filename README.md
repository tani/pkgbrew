# pkgbrew
[![Build Status](https://travis-ci.org/ta2gch/pkgbrew.svg?branch=master)](https://travis-ci.org/ta2gch/pkgbrew)

cmmand line interface for pkgsrc

## Usage

### Install package

```
$ pkgbrew install editors/emacs
```

### Uninstall package

```
$ pkgbrew deinstall editors/emacs
```

### Update package

```
$ pkgbrew replace editors/emacs
```

### Search package

```
$ pkgbrew search emacs
```

### Manage user repository (tap/untap)

```
$ pkgbrew tap <username>/<repository> # Github
$ pkgbrew untap <username>/<repository>
$ pkgbrew update # for all repository
```

For example,

```
$ pkgbrew tap NetBSD/pkgsrc-wip
```

### Show Usage

```
$ pkgbrew help
```

## Installation

```
$ wget -O- https://git.io/pkgbrew | /bin/sh

$ echo 'export PATH=$HOME/.pkgbrew/bin:$PATH' >> ~/.bashrc
$ echo 'export MANPATH=$HOME/.pkgbrew/man:$MANPATH' >> ~/.bashrc
```

## Dependencies

### Debian/Ubuntu

```
$ sudo apt-get install build-essential wget # or curl
```

## Author

TANIGUCHI Masaya

## Copyright

Copyright(c) 2016 TANIGUCHI Masaya (ta2gch@gmail.com)

## License

BSD License (2 clause)

