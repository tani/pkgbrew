#?include src/config.sh
search(){
    packagedir=`dirname "${1}" | tr '/' '#'`
    packagename=`basename "${1}"`
    find "${PKGSRC}" -maxdepth 2 -mindepth 2 -type d \
	| grep "${packagedir}/${packagename}" \
	| sed -e "s@${PKGSRC}/@@" \
	| tr '#' '/'
}

