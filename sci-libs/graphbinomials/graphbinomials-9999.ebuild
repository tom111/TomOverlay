# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 multilib

DESCRIPTION="Tools for graphs on monomials"
HOMEPAGE="https://github.com/tom111/GraphBinomials"
EGIT_REPO_URI="file:///home/tom/GraphBinomials"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	true
}

src_compile() {
	cd cpp
	emake
}

src_install() {
	dolib.so cpp/*.so*
	dosym libgraphbinomial.so.0 /usr/$(get_libdir)/libgraphbinomial.so
	dodir /usr/include/graphbinomials
	insinto /usr/include/graphbinomials
	doins cpp/*.h
}
