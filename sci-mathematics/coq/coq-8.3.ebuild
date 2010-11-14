# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils multilib

RESTRICT="strip installsources"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://${PN}.inria.fr/V${PV/_/}/files/${P/_/}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk debug +ocamlopt doc"

DEPEND=">=dev-lang/ocaml-3.12[ocamlopt?]
	>=dev-ml/camlp5-5.09[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )
	doc? ( dev-tex/hevea )"

S="${WORKDIR}/${P/_/}"

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/coq \
		--mandir /usr/share/man \
		--emacslib /usr/share/emacs/site-lisp \
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--camlp5dir ${ocaml_lib}/camlp5
		--lablgtkdir ${ocaml_lib}/lablgtk2"

	use debug && myconf="--debug $myconf"
#	use norealanalysis && myconf="$myconf --reals no"
#	use norealanalysis || myconf="$myconf --reals all"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"

	./configure $myconf || die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && domenu "${FILESDIR}/coqide.desktop"
}
