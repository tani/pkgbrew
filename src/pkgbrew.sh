#!/bin/sh

set -e

#?include src/config.sh
#?include src/version.sh
#?include src/help.sh
#?include src/search.sh
#?include src/tap.sh
#?include src/update.sh
#?include src/description.sh

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
	"description") description "${package}";;

	"help") run_command "${command}" "${package}" ;;
	"search") run_command "${command}" "${package}" ;;
	"setup") run_command "${command}" "${package}" ;;
	"depends") run_command "${command}" "${package}" ;;
	"fetch") run_command "${command}" "${package}" ;;
	"checksum") run_command "${command}" "${package}" ;;
	"extract") run_command "${command}" "${package}" ;;
	"patch") run_command "${command}" "${package}" ;;
	"configure") run_command "${command}" "${package}" ;;
	"all or build") run_command "${command}" "${package}" ;;
	"stage-install") run_command "${command}" "${package}" ;;
	"test") run_command "${command}" "${package}" ;;
	"package") run_command "${command}" "${package}" ;;
	"replace") run_command "${command}" "${package}" ;;
	"deinstall") run_command "${command}" "${package}" ;;
	"package-install") run_command "${command}" "${package}" ;;
	"install") run_command "${command}" "${package}" ;;
	"bin-install") run_command "${command}" "${package}" ;;
	"show-depends") run_command "${command}" "${package}" ;;
	"show-options") run_command "${command}" "${package}" ;;

	"clean-depends") run_command "${command}" "${package}" ;;
	"clean") run_command "${command}" "${package}" ;;
	"distclean") run_command "${command}" "${package}" ;;
	"package-clean") run_command "${command}" "${package}" ;;

	*)  echo Invalid command: ${1}
	    help ;;
    esac
}

main "${1}" "${2}"
