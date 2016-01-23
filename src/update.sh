#?include src/config.sh
#?include src/download.sh
#?include src/tap.sh

update(){
    workdir=`mktemp -d`

    download "${PKGHOST}" "-" | tar xz --directory "${PKGHOME}/var"
    ln --symbolic --force "${PKGHOME}/var/pkgsrc-trunk" "${PKGSRC}"

    if [ -f "${PKGHOME}/etc/user-repositories" ]; then
	cat "${PKGHOME}/etc/user-repositories" | while read $repo ;do
	    tap_without_check "$repo"
	done
    fi

    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"

    chmod +x "${PKGHOME}/bin/pkgbrew"
}
