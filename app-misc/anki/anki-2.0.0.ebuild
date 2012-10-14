# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="http://ichi2.net/anki/"
SRC_URI="http://ankisrs.net/download/mirror/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex +recording +sound"

RDEPEND="dev-python/PyQt4[X,svg,webkit]
	 dev-python/pysqlite:2
	 >=dev-python/httplib2-0.7.4
	 <dev-lang/python-3
	 dev-python/beautifulsoup:python-2
	 recording? ( media-sound/lame
				  >=dev-python/pyaudio-0.2.4 )
	 sound? ( media-video/mplayer )
	 latex? ( app-text/texlive
			  app-text/dvipng )"
DEPEND=""

S=${WORKDIR}/anki-2.0

src_prepare() {
	sed -i -e '0,/python/s//python2/' anki || die
	rm -r libanki/thirdparty || die
}

# Nothing to configure or compile
src_configure() {
	true;
}

src_compile() {
	true;
}

src_install() {
	exeinto /usr/bin/
	doexe anki
	rm anki || die

	doicon ${PN}.png
#	doins anki.xpm anki.png || die
	rm anki.xpm anki.png || die
	domenu anki.desktop
	rm anki.desktop || die

	doman anki.1
	rm anki.1 || die

	dodir /usr/share/anki
	insinto /usr/share/anki
	doins -r * || die

	make_desktop_entry ${PN} ${PN} ${PN} "Education"
}
