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
    
    workdir=`mktemp -d`
    
    download "https://github.com/${1}/archive/master.zip" \
	     "${workdir}/master.zip"
    
    unzip "${workdir}/master.zip" -d "${workdir}"
    
    cp --recursive                           \
       --verbose                             \
       "${workdir}/`basename "${1}"`-master" \
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
    
    rm --recursive \
       --verbose   \
       `convert_repository_name "${1}"`
}
