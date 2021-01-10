#!/bin/sh

set -e

#?include src/config.sh
#?include src/download.sh

main(){
    
    if [ -d "${PKGHOME}" ]; then
	echo pkgbrew already installed
	exit 1
    fi
	
    workdir=`mktemp -d /tmp/pkgbrew.XXXXXX`

    download "${PKGHOST}" "-" | tar -jx -C "${workdir}"

    prev="${SH}"
    export SH="/bin/bash"
    ${workdir}/pkgsrc/bootstrap/bootstrap        \
        --compiler=${CC}                               \
	    --ignore-user-check                            \
	    --workdir="${workdir}/work"                    \
	    --make-jobs="${MAKE_JOBS}"                     \
	    --prefix="${PKGHOME}" | awk "
#?include src/filter.awk
"
    export SH="${prev}"

    mv "${workdir}/pkgsrc" "${PKGSRC}"

    download "${PKGBREW}" "${PKGHOME}/bin/pkgbrew"
    chmod +x "${PKGHOME}/bin/pkgbrew"

    cat<<EOF > "${PKGHOME}/etc/mk.conf"
#?include src/mk.conf.tpl
EOF
}

main
