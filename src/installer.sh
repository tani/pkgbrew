#!/bin/sh

set -xe

#?include src/config.sh

#?include src/download.sh

main(){
    
    if [ -d "${PKGHOME}" ]; then
	echo pkgbrew already installed
	exit 1
    fi
	
    workdir=`mktemp -d`

    download "${PKGHOST}" "${workdir}/pkgsrc.tar.bz2" 

    tar --extract                \
	--verbose                \
	--bzip2                  \
	--directory "${workdir}" \
	--file "${workdir}/pkgsrc.tar.bz2"

    prev="${SH}"
    export SH="/bin/bash"
    ${workdir}/pkgsrc/bootstrap/bootstrap \
	--ignore-user-check               \
	--workdir="${workdir}/work"       \
	--prefix="${PKGHOME}"
    export SH="${prev}"

    echo Copying files...
    cp --recursive "${workdir}/pkgsrc" "${PKGSRC}"
    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"
    chmod +x "${PKGHOME}/bin/pkgbrew"

    cat<<EOF > "${PKGHOME}/etc/mk.conf"
#?include src/mk.conf.tpl
EOF

}

main
