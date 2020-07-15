# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit unpacker xdg-utils

#MY_PN="MindMaster"
#MY_PV=$(ver_cut 1)
#MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Baidu pinyin and wubi input method"
HOMEPAGE="https://srf.baidu.com/site/guanwang_linux/index.html"
SRC_URI="http://packages.deepin.com/deepin/pool/non-free/i/iflyime/iflyime_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND="
	app-i18n/opencc
	sys-apps/lsb-release
	app-arch/zip
	app-arch/unzip
	x11-libs/libX11
	>=sys-devel/gcc-4.6.0
	>=sys-libs/glibc-2.8
	>=sys-libs/zlib-1.2.0
	>=media-libs/portaudio-19.06.00
	>=x11-libs/gdk-pixbuf-2.22
	>=dev-libs/glib-2.12
	>=net-dns/libidn-1.13
	>=x11-libs/libnotify-0.7.0
	>=dev-qt/qtdbus-4.8.0
	>=dev-qt/qtdeclarative-4.8.0
	>=dev-qt/qtnetwork-4.8.0
	>=dev-qt/qtcore-4.8.0
	>=dev-qt/qtgui-4.8.0
	>=dev-qt/qtwebkit-4.8.0
	>=app-i18n/fcitx-4.2.0
	app-i18n/fcitx-qt5
	>=dev-libs/glib-2.12.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="
	/usr/lib64/iflyime_grpc/*.so*
	/usr/lib64/iflyime/*.so*
"

RESTRICT="mirror"

S="${WORKDIR}"
#DEB_NAME='fcitx-baidupinyin.deb'

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	insinto /usr
	doins -r ./usr/share/

	insinto /usr/lib64/fcitx
	doins usr/lib/x86_64-linux-gnu/fcitx/fcitx-iflyime.so
	fperms 0755 /usr/lib64/fcitx/fcitx-iflyime.so

	insinto /usr/lib64/
	doins -r usr/lib/iflyime_grpc usr/lib/iflyime
	fperms -R 0755 /usr/lib64/iflyime_grpc/
	fperms -R 0755 /usr/lib64/iflyime/
	#dolib.so ./opt/apps/com.baidu.fcitx-baidupinyin/files/lib/lib*.so

	exeinto /usr/bin
	doexe usr/bin/*
	insinto /etc/xdg/autostart/
	doins etc/xdg/autostart/*.desktop


	#fperms 0755 /opt/MindMaster-${MY_PV}/MindMaster
	#fperms -R 0755 /opt/apps/com.baidu.fcitx-baidupinyin/files/bin/
	#fperms -R 0755 /opt/apps/com.baidu.fcitx-baidupinyin/files/lib/
	#fperms -R 0755 /usr/lib/x86_64-linux-gnu/
	#dosym /opt/MindMaster-${MY_PV}/MindMaster /usr/bin/mindmaster
	#dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/applications/fcitx-ui-baidu-qimpanel.desktop /etc/xdg/autostart/fcitx-ui-baidu-qimpanel-ln.desktop
	#dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/applications/fcitx-ui-baidu-qimpanel.desktop /usr/share/applications/fcitx-ui-baidu-qimpanel.desktop
	#dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/locale/zh_CN/LC_MESSAGES/fcitx-baidupinyin.mo /usr/share/locale/zh_CN/LC_MESSAGES/fcitx-baidupinyin.mo
	#dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/icons/hicolor/48x48/apps/fcitx-baidupinyin.png /usr/share/icons/hicolor/48x48/apps/fcitx-baidupinyin.png
	#dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/icons/hicolor/16x16/apps/fcitx-baidupinyin.png /usr/share/icons/hicolor/16x16/apps/fcitx-baidupinyin.png

}
pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
