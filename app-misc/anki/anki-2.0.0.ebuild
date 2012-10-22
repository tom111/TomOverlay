# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.6"

inherit eutils python

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
	 dev-python/beautifulsoup:python-2
	 recording? ( media-sound/lame
				  >=dev-python/pyaudio-0.2.4 )
	 sound? ( media-video/mplayer )
	 latex? ( app-text/texlive
			  app-text/dvipng )"
DEPEND=""

S=${WORKDIR}/anki-2.0

pkg_setup(){
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -r libanki/thirdparty || die
	python_convert_shebangs -r 2 .
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

	doicon ${PN}.png
	domenu anki.desktop

	doman anki.1

	dodoc README README.development README.translating
	insinto "$(python_get_sitedir)"
	doins -r aqt libanki/anki

	make_desktop_entry ${PN} ${PN} ${PN} "Education"
}
