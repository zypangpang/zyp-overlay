# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit unpacker xdg-utils

#MY_PN="MindMaster"
#MY_PV=$(ver_cut 1)
#MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Baidu pinyin and wubi input method"
HOMEPAGE="https://srf.baidu.com/site/guanwang_linux/index.html"
SRC_URI="https://imeres.baidu.com/imeres/ime-res/guanwang/img/Ubuntu_Deepin-fcitx-baidupinyin-64.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""


DEPEND="
	>=sys-libs/glibc-2.4
	>=app-i18n/fcitx-4.2.0
	app-i18n/fcitx-qt5
	>=dev-libs/glib-2.12.0
	>=dev-qt/qtcore-5.7.1:5
	>=dev-qt/qtquickcontrols-5.5.1:5
"
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror"

S="${WORKDIR}"
DEB_NAME='fcitx-baidupinyin.deb'

src_unpack() {
	unpack ${A}
	unpack_deb ${DEB_NAME}
}

src_install() {
	insinto /usr
	doins -r ./usr/share/

	insinto /usr/lib64/fcitx
	doins ./opt/apps/com.baidu.fcitx-baidupinyin/files/lib/fcitx-baidupinyin.so
	fperms 0755 /usr/lib64/fcitx/fcitx-baidupinyin.so

	dolib.so ./opt/apps/com.baidu.fcitx-baidupinyin/files/lib/lib*.so

	insinto /
	doins -r ./opt/


	#fperms 0755 /opt/MindMaster-${MY_PV}/MindMaster
	fperms -R 0755 /opt/apps/com.baidu.fcitx-baidupinyin/files/bin/
	#fperms -R 0755 /opt/apps/com.baidu.fcitx-baidupinyin/files/lib/
	#fperms -R 0755 /usr/lib/x86_64-linux-gnu/
	#dosym /opt/MindMaster-${MY_PV}/MindMaster /usr/bin/mindmaster
	dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/applications/fcitx-ui-baidu-qimpanel.desktop /etc/xdg/autostart/fcitx-ui-baidu-qimpanel-ln.desktop
	dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/applications/fcitx-ui-baidu-qimpanel.desktop /usr/share/applications/fcitx-ui-baidu-qimpanel.desktop
	dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/locale/zh_CN/LC_MESSAGES/fcitx-baidupinyin.mo /usr/share/locale/zh_CN/LC_MESSAGES/fcitx-baidupinyin.mo
	dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/icons/hicolor/48x48/apps/fcitx-baidupinyin.png /usr/share/icons/hicolor/48x48/apps/fcitx-baidupinyin.png
	dosym /opt/apps/com.baidu.fcitx-baidupinyin/entries/icons/hicolor/16x16/apps/fcitx-baidupinyin.png /usr/share/icons/hicolor/16x16/apps/fcitx-baidupinyin.png

}
pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
