# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="digitaz is a downloader for the digital taz"
HOMEPAGE="http://git.gitorious.org/digitaz/digitaz"
SRC_URI="http://pi-ist-genau-3.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/pygtk
		dev-python/configobj
		>=dev-python/urlgrabber-3.9.1
		gnome-extra/zenity"

