package main

import (
	"flag"
	"log"
	"os"
	"os/exec"
	"path/filepath"
)

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
	showDepends := flag.Bool("D", false, "show depends")
	showOptions := flag.Bool("O", false, "show options")
	clean := flag.Bool("c", false, "clean packages")
	cleanDepends := flag.Bool("C", false, "clean depends")
	flag.Parse()
	if flag.NFlag() != 1 {
		flag.Usage()
		return
	}
	if *test {
		isNotNil(run("test", flag.Args()[2:]...))
	}
	if *init {
		isNotNil(pkgsrc())
	}
	if *install {
		isNotNil(run("install", flag.Args()[2:]...))
	}
	if *deinstall {
		isNotNil(run("deinstall", flag.Args()[2:]...))
	}
	if *replace {
		isNotNil(run("replace", flag.Args()[2:]...))
	}
	if *showDepends {
		isNotNil(run("show-depends", flag.Args()[2:]...))
	}
	if *showOptions {
		isNotNil(run("show-options", flag.Args()[2:]...))
	}
	if *clean {
		isNotNil(run("clean", flag.Args()[2:]...))
	}
	if *cleanDepends {
		isNotNil(run("clean-depends", flag.Args()[2:]...))
	}
}
