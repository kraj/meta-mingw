LIC_FILES_CHKSUM:class-nativesdk:mingw32 = "file://COPYING;md5=1c32c8e351f97e43e1ad6cf7f62de3bf"
SRCREV:class-nativesdk:mingw32 = "d4d918c1be631d770f09d2769834e5314cc9345a"
SRC_URI:class-nativesdk:mingw32 = "git://github.com/kraj/libtirpc-mingw;protocol=https;branch=main"

CFLAGS:append:class-nativesdk:mingw32 = " -D__REACTOS__"

EXTRA_OECONF:remove:class-nativesdk:mingw32 = "--disable-gssapi"
S:class-nativesdk:mingw32 = "${WORKDIR}/git"
B:class-nativesdk:mingw32 = "${S}"

do_install:append:class-nativesdk:mingw32() {
    install -Dm 0644 ${D}/etc/netconfig ${D}${sysconfdir}/netconfig
    rm -rf ${D}/etc
}
