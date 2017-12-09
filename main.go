package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var (
	revision string
)

func version() error {
	fmt.Printf(`pkgbrew revision : %s
Copyright (c) 2016 asciian

pkgbrew comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of pkgbrew under the terms of The BSD 2-Clause License.
For more infomation about these matters, see the file named LICENSE.
Homepage: https://github.com/asciian/pkgbrew
`, revision)
	return nil
}
func search(packages ...string) error {
	prefix := filepath.Join(os.Getenv("HOME"), ".pkgbrew")
	for _, pkg := range packages {
		dirs, err := filepath.Glob(filepath.Join(prefix, "src/*/*"))
		if err != nil {
			return err
		}
		for _, dir := range dirs {
			i := strings.Index(dir, pkg)
			if i >= 0 {
				ls := strings.Split(dir, "/")
				fmt.Println(filepath.Join(ls[len(ls)-2:]...))
			}
		}
	}
	return nil
}
func describe(packages ...string) error {
	prefix := filepath.Join(os.Getenv("HOME"), ".pkgbrew")
	for _, pkg := range packages {
		path := filepath.Join(prefix, "src", pkg, "DESCR")
		buf, err := ioutil.ReadFile(path)
		if err != nil {
			return err
		}
		os.Stdout.Write(buf)
	}
	return nil
}
func run(command string, packages ...string) error {
	prefix := filepath.Join(os.Getenv("HOME"), ".pkgbrew")
	cmd := exec.Command(filepath.Join(prefix, "bin", "bmake"), command)
	for _, pkg := range packages {
		path := filepath.Join(prefix, "src", pkg)
		if err := os.Chdir(path); err != nil {
			return err
		}
		if err := execute(cmd); err != nil {
			return err
		}
	}
	return nil
}

func isNotNil(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	init := flag.Bool("init", false, "initialization")
	test := flag.Bool("t", false, "test packages")
	install := flag.Bool("i", false, "install packages")
	deinstall := flag.Bool("d", false, "deinstall packages")
	replace := flag.Bool("r", false, "repalce packages")
	clean := flag.Bool("c", false, "clean packages")
	searchKeywords := flag.Bool("s", false, "search packages")
	showDepends := flag.Bool("D", false, "show depends of packages")
	showOptions := flag.Bool("O", false, "show options of packages")
	showInfomation := flag.Bool("I", false, "show infomation of packages")
	cleanDepends := flag.Bool("C", false, "clean depends")
	showVersion := flag.Bool("V", false, "show version of pkgbrew")
	flag.Parse()
	if flag.NFlag() != 1 {
		flag.Usage()
		return
	}
	if *test {
		isNotNil(run("test", flag.Args()...))
	}
	if *init {
		isNotNil(pkgsrc())
	}
	if *install {
		isNotNil(run("install", flag.Args()...))
	}
	if *deinstall {
		isNotNil(run("deinstall", flag.Args()...))
	}
	if *replace {
		isNotNil(run("replace", flag.Args()...))
	}
	if *showDepends {
		isNotNil(run("show-depends", flag.Args()...))
	}
	if *showOptions {
		isNotNil(run("show-options", flag.Args()...))
	}
	if *clean {
		isNotNil(run("clean", flag.Args()...))
	}
	if *cleanDepends {
		isNotNil(run("clean-depends", flag.Args()...))
	}
	if *showInfomation {
		isNotNil(describe(flag.Args()...))
	}
	if *searchKeywords {
		isNotNil(search(flag.Args()...))
	}
	if *showVersion {
		isNotNil(version())
	}
}
