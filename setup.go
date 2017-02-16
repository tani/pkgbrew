package main

import (
	"archive/tar"
	"compress/gzip"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
)

func writeFile(reader io.Reader, dest string, mode os.FileMode) error {
	file, err := os.Create(dest)
	if err != nil {
		return err
	}
	defer file.Close()
	_, err = io.Copy(file, reader)
	if err != nil {
		return err
	}
	if err := os.Chmod(dest, mode); err != nil {
		return err
	}
	return nil
}

func untgz(reader io.Reader, dest string) error {
	// gunzip
	gzipReader, err := gzip.NewReader(reader)
	if err != nil {
		return err
	}
	defer gzipReader.Close()
	// untar
	tarReader := tar.NewReader(gzipReader)
	for {
		header, err := tarReader.Next()
		if err == io.EOF {
			break
		} else if err != nil {
			return err
		}
		mode := os.FileMode(header.Mode)
		target := filepath.Join(dest, header.Name)
		switch header.Typeflag {
		case tar.TypeDir:
			if err = os.MkdirAll(target, mode); err != nil {
				return err
			}
			break
		case tar.TypeReg:
			if err := writeFile(tarReader, target, mode); err != nil {
				return err
			}
			break
		}
	}
	return nil
}
func env(key, fallback string) (v string) {
	v = os.Getenv(key)
	if len(v) == 0 {
		v = fallback
	}
	return
}
func pkgsrc() error {
	prefix := filepath.Join(os.Getenv("HOME"), "/.pkgbrew")
	cc := env("CC", "gcc")
	make_jobs := env("MAKE_JOBS", "1")
	pkgsrc_tar_gz := env("PKGSRC_TAR_GZ", "https://github.com/jsonn/pkgsrc/archive/trunk.tar.gz")
	workdir, err := ioutil.TempDir("/tmp", "pkgsrc")
	if err != nil {
		return err
	}
	defer os.RemoveAll(workdir)
	resp, err := http.Get(pkgsrc_tar_gz)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	if err := untgz(resp.Body, workdir); err != nil {
		return err
	}
	if err := os.Chdir(filepath.Join(workdir, "pkgsrc-trunk", "bootstrap")); err != nil {
		return err
	}
	os.Setenv("SH", "/bin/bash")
	cmd := exec.Command("./bootstrap",
		"--ignore-user-check",
		"--compiler="+cc,
		"--workdir="+filepath.Join(workdir, "work"),
		"--prefix="+prefix,
		"--make-jobs="+make_jobs)
	if err := execute(cmd); err != nil {
		return err
	}
	a := filepath.Join(workdir, "pkgsrc-trunk")
	b := filepath.Join(prefix, "src")
	if err := os.Rename(a, b); err != nil {
		return err
	}
	return nil
}
