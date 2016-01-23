#?include src/config.sh
#?include src/download.sh

convert_repository_name(){
    echo "${PKGSRC}/`echo ${1} | sed -e 's%/%-%g'`"
}

tap(){
    if [ -e `convert_repository_name "${1}"` ]; then
	echo repository already exits: ${1}
	exit 1;
    fi
    tap_without_check "${1}"
    echo ${1} >> "${PKGHOME}/etc/user-repositories"
}

tap_without_check(){
    download "https://github.com/${1}/archive/master.tar.gz" "-" \
	| tar xz --directory "${PKGHOME}/var"
    ln --symbolic --force "${PKGHOME}/`basename "${1}"`-master" \
       `convert_repository_name "${1}"`
}

untap(){
    if [ -z `echo ${1} | tr -d -c '/'` ]; then
	echo \'${1}\' is not user repository
	exit 1;
    elif [ ! -e `convert_repository_name "${1}"` ]; then
	echo repository already removed: ${1}
	exit 1;
    fi
    
    echo Deleting files...
    rm `convert_repository_name "${1}"`

    cp "${PKGHOME}/etc/user-repositories" \
       "${PKGHOME}/etc/user-repositories.bak"

    cat "${PKGHOME}/etc/user-repositories.bak" \
	| sed -e "s%${1}%#%g"                  \
	| sed -e "/#/d"                        \
	> "${PKGHOME}/etc/user-repositories"
}
