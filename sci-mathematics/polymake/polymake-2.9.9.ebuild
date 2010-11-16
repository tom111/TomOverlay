# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/polymake/polymake-2.9.8.ebuild,v 1.1 2010/11/03 08:39:25 tomka Exp $

EAPI=2

inherit flag-o-matic

DESCRIPTION="research tool for polyhedral geometry and combinatorics"
SRC_URI="http://www.opt.tu-darmstadt.de/polymake/lib/exe/fetch.php/download/${P}.tar.bz2"

HOMEPAGE="http://www.opt.tu-darmstadt.de/polymake"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

# TODO: Drop java.
DEPEND="dev-libs/gmp
	dev-libs/libxml2
	dev-perl/XML-LibXML
	dev-libs/libxslt
	dev-perl/XML-LibXSLT
	dev-perl/XML-Writer
	dev-perl/Term-ReadLine-Gnu
	>=virtual/jdk-1.5.0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i '/system "strip $to"/d' support/install.pl

	einfo "During compile this package uses up to"
	einfo "750MB of RAM per process. Use MAKEOPTS=\"-j1\" if"
	einfo "you run into trouble."
}

src_configure () {
	# Configure does not accept --host, therefore econf cannot be used
	./configure --prefix=/usr \
				--libdir=/usr/$(get_libdir)
}

# src_compile(){
# 	# Fixing makefile to not use escaped characters
# #	sed -i 's/uname -p/uname -i/' support/locate_build_dir
# 	# Remove stripping from install.pl
#
# 	# Configure is asking questions
# 	# First accept defaults
# ##	touch defaults || die "Cannot touch file"
# ##	emake configure < defaults
# ##	rm defaults
# ##
# ##	OFLAG=`get-flag -O`
# ##
# ##	# Now inject our answers
# ##	cd "${S}/build.`uname -i`"
# ##	sed -i 's,InstallTop=.*$,InstallTop=/usr/share/polymake,' conf.make
# ##	sed -i 's,InstallArch=.*$,InstallArch=/usr/lib/polymake,' conf.make
# ##	sed -i 's,InstallBin=.*$,InstallBin=/usr/bin,' conf.make
# ##	sed -i 's,InstallDoc=.*$,InstallDoc=/usr/share/doc/${PF},' conf.make
# ##	sed -i "s,CXXOPT=.*$,CXXOPT=${OFLAG}," conf.make
# ##	cd "${S}"
# ##	# The makefile respects CXXFLAGS and friends from the environment
#
# 	emake || die "emake failed"
# }

src_install(){
	emake -j1 DESTDIR="${D}" install || die "install failed"
}

pkg_postinst(){
	elog "Polymake uses Perl Modules compiled during install."
	elog "You have to reinstall polymake after an upgrade of Perl."
	elog " "
	elog "This version of polymake does not ship docs. Sorry."
	elog "Help can be found on http://www.opt.tu-darmstadt.de/polymake_doku/ "
	elog " "
	elog "On first start, polymake will ask you about the locations"
	elog "of external programs it can use."
	elog "If the initial run crashes, please report to the developers."
}
