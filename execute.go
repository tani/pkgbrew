package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"regexp"
)

func filter(scanner *bufio.Scanner) error {
	flag := false
	r1 := regexp.MustCompile("^={10}")
	r2 := regexp.MustCompile("^=+>")
	for scanner.Scan() {
		if r1.MatchString(scanner.Text()) {
			if flag {
				flag = false
				_, err := fmt.Println(scanner.Text())
				if err != nil {
					return err
				}
			} else {
				flag = true
			}
		}
		if r2.MatchString(scanner.Text()) || flag {
			_, err := fmt.Println(scanner.Text())
			if err != nil {
				return err
			}
		}
	}
	return nil
}
func execute(cmd *exec.Cmd) error {
	cmd.Stderr = os.Stderr
	out, err := cmd.StdoutPipe()
	if err != nil {
		return err
	}
	if err := cmd.Start(); err != nil {
		return err
	}
	if err := filter(bufio.NewScanner(out)); err != nil {
		return err
	}
	if err := cmd.Wait(); err != nil {
		return err
	}
	return nil
}
