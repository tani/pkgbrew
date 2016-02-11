#?include src/config.sh
# Example ${PKGHOME}/etc/mk.conf file produced by pkgbrew
# `date`

.ifdef BSD_PKG_MK	# begin pkgsrc settings

UNPRIVILEGED=		yes
PKG_DBDIR=		${PKGHOME}/var/db/pkg
LOCALBASE=		${PKGHOME}
VARBASE=		${PKGHOME}/var
PKG_TOOLS_BIN=		${PKGHOME}/sbin
PKGINFODIR=		info
PKGMANDIR=		man
MAKE_JOBS=              ${MAKE_JOBS}
PKGSRC_COMPILER=	${CC}

TOOLS_PLATFORM.awk?=	${PKGHOME}/bin/nawk
TOOLS_PLATFORM.sh?=	/bin/bash

PKG_DEFAULT_OPTIONS=    -x11 -gtk2 -gkt3 -gnome -kde
.endif			# end pkgsrc settings
