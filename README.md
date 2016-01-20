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
$ ./brew setup-for bashrc > ~/.bashrc 
```
or
```
$ ./brew setup-for zshrc > ~/.zshrc 
```
or 
```
$ ./brew setup-for tschrc > ~/.tschrc 
```

## Dependencies

### Debian/Ubuntu

```
sudo apt-get install build-essential libncurses-dev libncursesw-dev
```