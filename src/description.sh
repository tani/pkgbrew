#?include src/config.sh
description(){
    package="${PKGSRC}/${1}"
    if [ ! -n "${1}" -o ! -d "${package}" ]; then
	echo No package \'${2}\' found, did you mead:
	search "${1}" | sed -e "s/^/ /"
	echo pkgbrew: package not found
	exit 1;
    fi

    cat "${package}/DESCR"
}
