#?include src/config.sh
#?include src/download.sh

convert_repository_name(){
    echo "${PKGSRC}/`echo ${1} | sed -e 's%/%#%g'`"
}

tap(){
    if [ -d `convert_repository_name "${1}"` ]; then
	echo repository already exits: ${1}
	exit 1;
    fi
    
    mkdir `convert_repository_name "${1}"`

    echo "${1}" >> "${PKGHOME}/etc/user-repositories"

    download "https://github.com/${1}/archive/master.tar.gz" "-" \
	| tar xz \
	      --strip-components 1 \
	      --directory `convert_repository_name "${1}"`
}

untap(){
    if [ -z `echo ${1} | tr -d -c '/'` ]; then
	echo \'${1}\' is not user repository
	exit 1;
    elif [ ! -d `convert_repository_name "${1}"` ]; then
	echo repository already removed: ${1}
	exit 1;
    fi
    
    echo Deleting repository...

    rm --recursive `convert_repository_name "${1}"`

    echo Completed.

    cp "${PKGHOME}/etc/user-repositories" \
       "${PKGHOME}/etc/user-repositories.bak"

    cat "${PKGHOME}/etc/user-repositories.bak"  \
	| sed -e "s%${1}%##%g"                  \
	| sed -e "/##/d"                        \
	> "${PKGHOME}/etc/user-repositories"
}
