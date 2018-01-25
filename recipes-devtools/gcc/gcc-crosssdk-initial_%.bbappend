DEPENDS_append_mingw32 = " mingw-w64-headers"
DEPENDS_append_mingw32_nativesdk = " nativesdk-mingw-w64-headers"
EXTRA_OECONF_remove_mingw32 = "--enable-initfini-array"
EXTRA_OECONF_append_mingw32 = " --disable-initfini-array"
