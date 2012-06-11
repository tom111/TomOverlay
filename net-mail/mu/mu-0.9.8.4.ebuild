# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mu/mu-0.9.7.ebuild,v 1.1 2011/11/21 12:18:55 eras Exp $

EAPI=4

inherit base elisp-common

DESCRIPTION="Set of tools to deal with Maildirs, in particular, searching and indexing"
HOMEPAGE="http://www.djcbsoftware.nl/code/mu/"
SRC_URI="http://mu0.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs gui"

DEPEND="
	>=dev-libs/gmime-2.4:2.4
	dev-libs/xapian
	dev-libs/glib:2
	gui? (
	  x11-libs/gtk+:3 )
	emacs? ( >=virtual/emacs-23 )"
RDEPEND="${DEPEND}"
# 	  net-libs/webkit-gtk:3 )


SITEFILE="70mu-gentoo.el"

src_configure() {
	local guiconf
	if use gui; then
		guiconf="--with-gui=gtk3"
	else
		guiconf="--with-gui=none"
	fi

	econf "${guiconf}"
}

src_install () {
	base_src_install
	# Installing the guis is not supported by upstream
	if use gui; then
		dobin toys/mug/mug || die
	fi
	dodoc AUTHORS HACKING NEWS TODO README ChangeLog INSTALL
	if use emacs; then
		elisp-install ${PN} emacs/*.el emacs/*.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

}

pkg_postinst() {
	if use emacs; then
		einfo "To use mu4e you need to configure it in your .emacs file"
		einfo "See the manual for more information:"
		einfo "http://www.djcbsoftware.nl/code/mu/mu4e/Getting-started.html"
	fi

	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
