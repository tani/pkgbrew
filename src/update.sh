#?include src/config.sh
#?include src/download.sh
#?include src/tap.sh

update(){
    workdir=`mktemp -d`

    rm -rf "${PKGSRC}"
    
    download "${PKGHOST}" "-" \
	| tar xz --strip-components 1 --directory "${PKGSRC}"
    
    if [ -f "${PKGHOME}/etc/user-repositories" ]; then
	cat "${PKGHOME}/etc/user-repositories" | while read $repo ;do
	    untap "${repo}"
	    tap "${repo}"
	done
    fi

    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"

    chmod +x "${PKGHOME}/bin/pkgbrew"
}
