# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="generator of sandwich OCR pdf files"
HOMEPAGE="http://pdfsandwich.origo.ethz.ch/wiki/pdfsandwich"
SRC_URI="http://download.origo.ethz.ch/pdfsandwich/1809/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="<app-text/cuneiform-0.9.0[imagemagick]
	media-gfx/exact-image
	app-text/ghostscript-gpl"

DEPEND="sys-apps/gawk
	>=dev-lang/ocaml-3.08[ocamlopt]"

RESTRICT="mirror"

src_compile() {
	econf
	emake ${MAKEOPTS} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
