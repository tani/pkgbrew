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
    genre=`dirname "${2}" | tr '/' '_'`
    packagename=`basename "${2}"`
    packagedir="${PKGSRC}/${genre}/${packagename}"

    if [ ! -n "${2}" -o ! -d "${packagedir}" ]; then
	echo No package \'${2}\' found, did you mead:
	search "${2}" | sed -e "s/^/ /"
	echo pkgbrew: package not found
	exit 1;
    fi

    cd "${packagedir}"

    case "${command}" in
	"show-depends"|"show-options"|"print-PLIST")
	    ${PKGHOME}/bin/bmake "${command}" ;;
	*) ${PKGHOME}/bin/bmake "${command}" | awk "
#?include src/filter.awk
" ;;
    esac
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

	"makesum") run_command "${command}" "${package}" ;;
	"makepatchsum") run_command "${command}" "${package}" ;;
	"makedistinfo") run_command "${command}" "${package}" ;;
	"print-PLIST") run_command "${command}" "${package}" ;;
	*)  echo Invalid command: ${1}
	    help ;;
    esac
}

main "${1}" "${2}"
