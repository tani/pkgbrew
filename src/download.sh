download_1(){
    from="${1}"
    dest="${2}"
    if which wget > /dev/null ; then
	wget -O "${dest}" "${from}"
    elif which curl > /dev/null ; then
	if [ "${dest}" = "-" ] ; then
	    curl -L "${from}"
	else
	    curl -L -o "${dest}" -O "${from}"
	fi
    fi
}

download(){
    from="${1}"
    dest="${2}"
    case "${from}" in
	https://*) download_1 "${from}" "${dest}" ;;
	http://*) download_1 "${from}" "${dest}" ;;
	*) cp "${from}" "${dest}" ;;
    esac
}
