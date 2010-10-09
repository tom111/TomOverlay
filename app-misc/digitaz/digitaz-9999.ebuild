# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/tatt/tatt-9999.ebuild,v 1.1 2010/07/27 12:36:56 fauli Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils git

DESCRIPTION="digitaz is a downloader for the digital taz"
HOMEPAGE="http://git.gitorious.org/digitaz/digitaz"
EGIT_REPO_URI="git://gitorious.org/digitaz/digitaz.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="dev-python/pygtk
		dev-python/configobj
		>=dev-python/urlgrabber-3.9.1
		gnome-extra/zenity"

S="${WORKDIR}/${PN}"
