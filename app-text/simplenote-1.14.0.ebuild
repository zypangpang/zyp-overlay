# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit eutils unpacker

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://github.com/Automattic/simplenote-electron"
SRC_URI="https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/Simplenote-linux-${PV}-amd64.deb"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# RESTRICT="mirror"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mv * "${D}" || die
}
