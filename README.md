# pkgbrew

non-root package manager

## Usage

### Install a package

```
$ pkgbrew install editors/emacs-nox11
```

### Uninstall a package

```
$ pkgbrew deinstall editors/emacs-nox11
```

### Upgrade a package

```
$ pkgbrew replace editors/emacs-nox11
```

### Show build parameters

```
$ pkgbrew show-options editors/emacs24
```

### Search a package

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
$ export MAKE_JOBS=4 # Optional
$ wget -O- https://raw.githubusercontent.com/tani/pkgbrew/master/bin/installer | /bin/sh
$ echo 'export PATH=$HOME/.pkgbrew/bin:$PATH' >> ~/.bashrc
$ echo 'export MANPATH=$HOME/.pkgbrew/man:$MANPATH' >> ~/.bashrc
```

## Supported platforms

- NetBSD
- Solaris
- Linux (test environment)
- Darwin(Mac OS X) (Travis CI)
- FreeBSD

(see also pkgsrc.org)

## Software requirements

- wget or curl
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

Copyright(c) 2016-2020 TANIGUCHI Masaya

## License

BSD License (2 clause)

