# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit desktop gnome2-utils multilib unpacker xdg-utils

MY_PN="ONLYOFFICE-DesktopEditors"
MY_P="${MY_PN}-${PVR//r}"

DESCRIPTION="onlyoffice is an office productivity suite (binary version)"
HOMEPAGE="https://www.onlyoffice.com/"

KEYWORDS="amd64 x86"


SRC_URI="
	amd64? (
		https://github.com/ONLYOFFICE/DesktopEditors/releases/download/${MY_P}/${PN/bin/desktopeditors}_amd64.deb -> ${MY_P}_amd64.deb
	)
"

SLOT="0"
RESTRICT="mirror strip"
LICENSE="AGPL-3"
IUSE=""

NATIVE_DEPEND="
	x11-base/xorg-server
	media-libs/alsa-lib
	dev-libs/atk
	gnome-base/gconf
	sys-devel/gcc
	media-fonts/dejavu
	media-fonts/liberation-fonts
	media-fonts/crosextrafonts-carlito
	net-misc/wget
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-misc/xdg-utils
"
RDEPEND="
	${NATIVE_DEPEND}
	!app-office/onlyoffice
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack(){
	unpack_deb "${A}"
}

src_install() {
	mkdir -p ${D}
	cp -r . ${D}
	local res
	for res in 16 24 32 48 64 128 256; do
		doicon -s ${res} opt/onlyoffice/desktopeditors/asc-de-${res}.png
	done
	#dosym "${EPREFIX}/usr/$(get_libdir)/libcurl-gnutls.so.4" "${EPREFIX}/opt/onlyoffice/desktopeditors/libcurl-gnutls.so.4"
}

pkg_preinst(){
	gnome2_gconf_savelist
	xdg_environment_reset
}

pkg_postinst() {
	gnome2_gconf_install
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

