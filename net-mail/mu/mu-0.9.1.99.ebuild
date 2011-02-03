# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools base eutils

DESCRIPTION="Set of tools to deal with Maildirs, in particular, searching and indexing"
HOMEPAGE="http://www.djcbsoftware.nl/code/mu/"
SRC_URI="http://mu0.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/gmime-2.4
	dev-libs/xapian
	>=dev-libs/glib-2.22"
RDEPEND="${DEPEND}"

S="${WORKDIR}/mu-ng/"

src_prepare() {
	eautoreconf
}

src_test () {
	emake check || die
}

DOCS=( "AUTHORS" "HACKING" "NEWS" "TODO" )
