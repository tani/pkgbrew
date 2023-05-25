#?include src/config.sh
#?include src/download.sh
#?include src/tap.sh

update(){
    download "${PKGHOST}" "-" \
	| tar xj --strip-components 1 -C "${PKGSRC}"

    if [ -f "${PKGHOME}/etc/user-repositories" ]; then
	cat "${PKGHOME}/etc/user-repositories" | while read repo ;do
	    untap "${repo}"
	    tap "${repo}"
	done
    fi

    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"

    chmod +x "${PKGHOME}/bin/pkgbrew"
}
