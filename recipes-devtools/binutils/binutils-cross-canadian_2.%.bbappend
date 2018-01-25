EXTRA_OECONF_append_mingw32 = " --disable-plugins --disable-nls"
LDFLAGS_append_mingw32 = " -Wl,-static"

DEPENDS_remove_mingw32 = "gettext"
DEPENDS_remove_mingw32 = "flex"

EXTRA_OECONF_append_sdkmingw32 = " --disable-plugins --disable-nls"
LDFLAGS_append_sdkmingw32 = " -Wl,-static"

DEPENDS_remove_sdkmingw32 = "nativesdk-gettext"
DEPENDS_remove_sdkmingw32 = "nativesdk-flex"
