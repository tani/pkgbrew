#?include src/config.sh
search(){
    package="${1}"
    find "${PKGSRC}" -maxdepth 2 \
	| grep "${package}"  \
	| sed --expression="s%${PKGSRC}/%%" 
}
