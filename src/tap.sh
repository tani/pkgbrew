#?include src/config.sh
#?include src/download.sh

convert_repository_name(){
    echo "${PKGSRC}/`echo ${1} | sed -e 's%/%-%g'`"
}

tap(){
    if [ -d `convert_repository_name "${1}"` ]; then
	echo repository already exits: ${1}
	exit 1;
    fi
    tap_without_check "${1}"
    echo ${1} >> "${PKGHOME}/etc/user-repositories"
}

tap_without_check(){
    workdir=`mktemp -d`
    
    download "https://github.com/${1}/archive/master.zip" \
	     "${workdir}/master.zip"
    
    echo Extracting files...

    unzip "${workdir}/master.zip" -d "${workdir}" > /dev/null
    
    echo Copying files...

    cp --recursive --force "${workdir}/`basename "${1}"`-master" \
       `convert_repository_name "${1}"`
}

untap(){
    if [ -z `echo ${1} | tr -d -c '/'` ]; then
	echo \'${1}\' is not user repository
	exit 1;
    elif [ ! -d `convert_repository_name "${1}"` ]; then
	echo repository already removed: ${1}
	exit 1;
    fi
    
    echo Deleting files...
    rm --recursive `convert_repository_name "${1}"`

    cp "${PKGHOME}/etc/user-repositories" \
       "${PKGHOME}/etc/user-repositories.bak"

    cat "${PKGHOME}/etc/user-repositories.bak" \
	| sed -e "s%${1}%#%g"                  \
	| sed -e "/#/d"                        \
	> "${PKGHOME}/etc/user-repositories"
}
