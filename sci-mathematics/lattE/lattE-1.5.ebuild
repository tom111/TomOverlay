# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils eutils

MYPN="latte"
MYPF="${MYPN}-integrale-${PV}"

DESCRIPTION="lattE consists of tools for lattice point enumeration"
SRC_URI="http://www.math.ucdavis.edu/~${MYPN}/software/${MYPF}.tar.gz"
#	mirror://gentoo/${P}-src.tar.bz2

HOMEPAGE="http://www.math.ucdavis.edu/~latte/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/gmp[-nocxx]
	>=dev-libs/ntl-5.4.2
	sci-mathematics/4ti2
	>=sci-libs/cddlib-094f"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYPF}"

# For now LattE builds an internal version of Lidia.
# This will not be split off for now because it is heavily patched
# and based on a version that was not even released.

src_prepare() {
	epatch "${FILESDIR}/fix-build-system.patch"
	eautoreconf
}

src_install() {
	# install
	cd "${S}"/lidia-2.3.0/
	emake install || die "Install failed"
	cd "${S}"/latte-int-1.5/
	emake  install || die "Install failed"
}
