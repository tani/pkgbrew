#!/bin/sh

set -e

#?include src/config.sh
#?include src/version.sh
#?include src/help.sh
#?include src/search.sh
#?include src/tap.sh
#?include src/update.sh

run_command(){
    command="${1}"
    package="${PKGSRC}/${2}"

    if [ ! -n "${2}" -o ! -d "${package}" ]; then
	echo No package \'${2}\' found, did you mead:
	search "${2}" | sed --expression="s/^/ /"
	echo pkgbrew: package not found
	exit 1;
    fi

    cd "${package}"
    if [ "${command}" = "show-depends" -o "${command}" = "show-options" ]; then
	${PKGHOME}/bin/bmake "${command}" 
    else
	${PKGHOME}/bin/bmake "${command}" | awk "
#?include src/filter.awk
"
    fi
}

main(){
    command="${1}"
    package="${2}"

    case "${command}" in
	"help") help ;;
	"search") search "${package}" ;;
	"tap") tap "${package}" ;;
	"untap") untap "${package}" ;;
	"version") version ;;
	"update") update ;;

	"help") run_command "${1}" "${2}" ;;
	"search") run_command "${1}" "${2}" ;;
	"setup") run_command "${1}" "${2}" ;;
	"depends") run_command "${1}" "${2}" ;;
	"fetch") run_command "${1}" "${2}" ;;
	"checksum") run_command "${1}" "${2}" ;;
	"extract") run_command "${1}" "${2}" ;;
	"patch") run_command "${1}" "${2}" ;;
	"configure") run_command "${1}" "${2}" ;;
	"all or build") run_command "${1}" "${2}" ;;
	"stage-install") run_command "${1}" "${2}" ;;
	"test") run_command "${1}" "${2}" ;;
	"package") run_command "${1}" "${2}" ;;
	"replace") run_command "${1}" "${2}" ;;
	"deinstall") run_command "${1}" "${2}" ;;
	"package-install") run_command "${1}" "${2}" ;;
	"install") run_command "${1}" "${2}" ;;
	"bin-install") run_command "${1}" "${2}" ;;
	"show-depends") run_command "${1}" "${2}" ;;
	"show-options") run_command "${1}" "${2}" ;;

	"clean-depends") run_command "${1}" "${2}" ;;
	"clean") run_command "${1}" "${2}" ;;
	"distclean") run_command "${1}" "${2}" ;;
	"package-clean") run_command "${1}" "${2}" ;;

	*)  echo Invalid command: ${1}
	    help ;;
    esac
}

main "${1}" "${2}"
