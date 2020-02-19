# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit unpacker xdg-utils

#MY_PN="MindMaster"
MY_PV=$(ver_cut 1)
#MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Mind mapping and brainstorming tool"
HOMEPAGE="https://www.edrawsoft.com/mindmaster/"
SRC_URI="https://www.edrawsoft.com/archives/mindmaster-${MY_PV}-amd64.deb"

LICENSE="EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"

#src_unpack() {
#	unpack_deb ${A}
#}

src_install() {
	insinto /usr/share
	doins -r ./usr/share/applications

	insinto /opt
	doins -r ./opt/MindMaster-${MY_PV}

	fperms 0755 /opt/MindMaster-${MY_PV}/MindMaster

	dosym /opt/MindMaster-${MY_PV}/MindMaster /usr/bin/mindmaster
}
pkg_postinst() {
	xdg_desktop_database_update
	#xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	#xdg_icon_cache_update
}
