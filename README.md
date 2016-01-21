# pkgbrew
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

### Search package

```
$ pkgbrew search emacs
```

### Show Usage

```
$ pkgbrew help
```

## Installation

```
$ wget -O- https://raw.githubusercontent.com/ta2gch/pkgbrew/master/bin/installer.sh | /bin/sh

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

