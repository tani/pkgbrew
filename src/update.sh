#?include src/config.sh
#?include src/download.sh
#?include src/tap.sh

update(){
    workdir=`mktemp -d`

    download "${PKGHOST}" "${workdir}/pkgsrc.tar.bz2"

    echo Extracting files...

    tar --extract                \
	--bzip2                  \
	--directory "${workdir}" \
	--file "${workdir}/pkgsrc.tar.bz2"

    echo Copying files...

    cp --recursive --force "${workdir}/pkgsrc" "${PKGSRC}"

    if [ -f "${PKGHOME}/etc/user-repositories" ]; then
	cat "${PKGHOME}/etc/user-repositories" | while read $repo ;do
	    tap_without_check "$repo"
	done
    fi

    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"

    chmod +x "${PKGHOME}/bin/pkgbrew"
}
