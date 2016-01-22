#!/bin/sh

set -e

#?include src/config.sh

#?include src/download.sh

main(){
    
    if [ -d "${PKGHOME}" ]; then
	echo pkgbrew already installed
	exit 1
    fi
	
    workdir=`mktemp -d`

    download "${PKGHOST}" "${workdir}/trunk.zip" 

    echo Extracing files...

    unzip "${workdir}/trunk.zip" -d "${workdir}" > /dev/null

    prev="${SH}"
    export SH="/bin/bash"
    ${workdir}/pkgsrc-trunk/bootstrap/bootstrap \
	--ignore-user-check               \
	--workdir="${workdir}/work"       \
	--prefix="${PKGHOME}"
    export SH="${prev}"

    echo Copying files...
    mv "${workdir}/pkgsrc-trunk" "${PKGSRC}"
    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"
    chmod +x "${PKGHOME}/bin/pkgbrew"

    cat<<EOF > "${PKGHOME}/etc/mk.conf"
#?include src/mk.conf.tpl
EOF

}

main
