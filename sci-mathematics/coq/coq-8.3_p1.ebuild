# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.3.ebuild,v 1.2 2010/11/20 12:44:09 tomka Exp $

EAPI="2"

inherit eutils multilib

MY_PV=${PV/_p/pl}
MY_P=${PN}-${MY_PV}


DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://${PN}.inria.fr/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gtk debug +ocamlopt doc"

RDEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	>=dev-ml/camlp5-5.09[ocamlopt?]
	gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"
DEPEND="${RDEPEND}
	doc? (
		media-libs/netpbm[png,zlib]
		virtual/latex-base
		dev-tex/hevea
		dev-tex/xcolor
		|| ( dev-texlive/texlive-pictures app-text/ptex )
		|| ( dev-texlive/texlive-mathextra app-text/ptex )
		|| ( dev-texlive/texlive-latexextra app-text/ptex )
		)"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# From upstream CVS, remove on next patchlevel:
# 	epatch "${FILESDIR}/${P}-camlp5-6-compat.patch"
# 	epatch "${FILESDIR}/${P}-make-3.82-compat.patch"
	# configure has an error at line 640 leading to closing a string
	# to early in the generated coq_config.ml. Here is a wild sed :)
	# It replaces \"$LABLGTKLIB\" by $LABLGTKLIB
	sed -i "s/\\\\\"\\\$LABLGTKLIB\\\\\"/\\\$LABLGTKLIB/" configure
}

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr
		--bindir /usr/bin
		--libdir /usr/$(get_libdir)/coq
		--mandir /usr/share/man
		--emacslib /usr/share/emacs/site-lisp
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--docdir /usr/share/doc/${PF}
		--camlp5dir ${ocaml_lib}/camlp5
		--lablgtkdir ${ocaml_lib}/lablgtk2"

	use debug && myconf="--debug $myconf"
	use doc || myconf="$myconf --with-doc no"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"
	use ocamlopt && myconf="$myconf --opt"

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure $myconf || die "configure failed"
}

src_compile() {
	emake STRIP="true" -j1 || die "make failed"
}

src_install() {
	emake STRIP="true" COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && domenu "${FILESDIR}/coqide.desktop"
}
