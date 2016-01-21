help(){
    cat<<EOF
pkgbrew <command> [<package>]
command:

    help		: show usage 
    search		: search packages

    Build pkgsrc package 

    depends		: build and install dependencies
    fetch		: fetch distribution file(s)
    checksum		: fetch and check distribution file(s)
    extract		: look at unmodified source
    patch		: look at initial source
    configure		: stop after configure stage
    all or build	: stop after build stage
    stage-install	: install under stage directory
    test		: run package's self-tests, if any exist and supported
    package		: create binary package before installing it
    replace		: change (upgrade, downgrade, or just replace) installed package in-place
    deinstall		: deinstall previous package
    package-install	: install package and build binary package
    install		: install package
    bin-install		: attempt to skip building from source and use pre-built binary package
    show-depends        : print dependencies for building
    show-options        : print available options from options.mk

    Cleanup targets (in separate section because of importance):

    clean-depends	: remove work directories for dependencies
    clean		: remove work directory
    distclean		: remove distribution file(s)
    package-clean	: remove binary package

EOF
}
