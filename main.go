package main

import (
	"fmt"
	"flag"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"io/ioutil"
)

var (
	revision string
)

func version() error {	
	fmt.Printf(`pkgbrew revision : %s
Copyright (c) 2016 TANIGUCHI Masaya

pkgbrew comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of pkgbrew under the terms of The BSD 2-Clause License.
For more infomation about these matters, see the file named LICENSE.
Homepage: https://github.com/ta2gch/pkgbrew
`, revision)
	return nil
}
func search(packages ...string) error {
	prefix := filepath.Join(os.Getenv("HOME"), ".pkgbrew")
	for _, pkg := range packages {
		dirs, err := filepath.Glob(filepath.Join(prefix,"src/*/*"))
		if err != nil {
			return err
		}
		for _, dir := range dirs {
			matched, err := filepath.Match(filepath.Join(prefix,"src",pkg),dir)
			if err != nil {
				return err
			}
			if matched {
				fmt.Println(pkg)
			}
		}
	}
	return nil	
}
func describe(packages ...string) error {
	prefix := filepath.Join(os.Getenv("HOME"), ".pkgbrew")
	for _, pkg := range packages {
		path := filepath.Join(prefix, "src", pkg,"DESCR")
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
	cmd := exec.Command(filepath.Join(prefix,"bin","bmake"), command)
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
	searchKeywords := flag.Bool("s",false, "search packages")
	showDepends := flag.Bool("D", false, "show depends of packages")
	showOptions := flag.Bool("O", false, "show options of packages")
	showInfomation := flag.Bool("I",false,"show infomation of packages")
	cleanDepends := flag.Bool("C", false, "clean depends")
	showVersion := flag.Bool("V",false, "show version of pkgbrew")
	flag.Parse()
	if flag.NFlag() != 1 {
		flag.Usage()
		return
	}
	if *test {
		isNotNil(run("test", flag.Args()[1:]...))
	}
	if *init {
		isNotNil(pkgsrc())
	}
	if *install {
		isNotNil(run("install", flag.Args()[1:]...))
	}
	if *deinstall {
		isNotNil(run("deinstall", flag.Args()[1:]...))
	}
	if *replace {
		isNotNil(run("replace", flag.Args()[1:]...))
	}
	if *showDepends {
		isNotNil(run("show-depends", flag.Args()[1:]...))
	}
	if *showOptions {
		isNotNil(run("show-options", flag.Args()[1:]...))
	}
	if *clean {
		isNotNil(run("clean", flag.Args()[1:]...))
	}
	if *cleanDepends {
		isNotNil(run("clean-depends", flag.Args()[1:]...))
	}
	if *showInfomation {
		isNotNil(describe(flag.Args()[1:]...))
	}
	if *searchKeywords {
		isNotNil(search(flag.Args()[1:]...))
	}
	if *showVersion {
		isNotNil(version())
	}
}
