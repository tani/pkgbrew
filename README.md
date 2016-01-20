# pkgbrew
cmmand line interface for pkgsrc

## Usage

### Install package

```
$ pkgbrew install editors/emacs
```

### Uninstall pakcage

```
$ pkgbrew deinstall editors/emacs
```

### Search pakcage

```
$ pkgbrew search emacs
```

### Show Usage

```
$ pkgbrew help
```

## Installation

```
$ ./pkgbrew init
$ ./pkgbrew setup-for bashrc >> ~/.bashrc 
```
or
```
$ ./pkgbrew init
$ ./pkgbrew setup-for zshrc >> ~/.zshrc 
```
or 
```
$ ./pkgbrew init
$ ./pkgbrew setup-for tschrc >> ~/.tschrc 
```

## Dependencies

### Debian/Ubuntu

```
sudo apt-get install build-essential
```

## Author

TANIGUCHI Masaya

## Copyright

Copyright(c) 2016 TANIGUCHI Masaya (ta2gch@gmail.com)

## License

BSD License (2 clause)

