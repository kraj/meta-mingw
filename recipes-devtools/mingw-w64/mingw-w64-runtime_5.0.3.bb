DESCRIPTION = "Runtime libraries from MinGW-w64 project"
LICENSE = "ZPL-2.1"
LIC_FILES_CHKSUM = "file://../COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"

COMPATIBLE_HOST = ".*-mingw.*"

SRC_URI = "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${PV}.tar.bz2"

SRC_URI[md5sum] = "5524c20312560cc8683b7d8ee292cb8c"
SRC_URI[sha256sum] = "2a601db99ef579b9be69c775218ad956a24a09d7dabc9ff6c5bd60da9ccc9cb4"

S = "${WORKDIR}/mingw-w64-v${PV}/mingw-w64-crt"
B = "${WORKDIR}/build-${TARGET_SYS}"

inherit autotools

BUILDSDK_CPPFLAGS_append = " -isystem${STAGING_INCDIR}"
TARGET_CPPFLAGS_append = " -isystem${STAGING_INCDIR}"

INHIBIT_DEFAULT_DEPS = "1"
DEPENDS = "mingw-w64-headers virtual/${TARGET_PREFIX}gcc-initial "

PROVIDES += "virtual/libc"
PROVIDES += "virtual/${TARGET_PREFIX}libc-initial"
PROVIDES += "virtual/${TARGET_PREFIX}libc-for-gcc"

# Work around pulling in eglibc for now...
PROVIDES += "virtual/libintl"

STAGINGCC = "gcc-cross-initial-${TARGET_ARCH}"
STAGINGCC_class-nativesdk = "gcc-crosssdk-initial-${SDK_SYS}"
TOOLCHAIN_OPTIONS = " --sysroot=${STAGING_DIR_TARGET}"
PATH_prepend = "${STAGING_BINDIR_TOOLCHAIN}.${STAGINGCC}:"

EXTRA_OECONF += "--with-sysroot=${STAGING_DIR_TARGET}"
EXTRA_OECONF_append_x86-64 = " --disable-lib32"
EXTRA_OECONF_append_x86 = " --disable-lib64"

do_configure() {
    oe_runconf
}

FILES_${PN} += "${exec_prefix}/libsrc"

BBCLASSEXTEND = "nativesdk"

SECURITY_CFLAGS_remove_mingw32 = "-fstack-protector-strong"
