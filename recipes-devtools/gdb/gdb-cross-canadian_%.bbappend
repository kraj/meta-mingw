LDFLAGS_append_mingw32 = " -Wl,-static"
EXEEXT_mingw32 = ".exe"
DEPENDS_remove_mingw32 = "ncurses readline python"
RDEPENDS_${PN}_remove_mingw32 = "python-core python-lang python-re python-codecs python-netclient"
EXTRA_OECONF_append_mingw32 = " --without-curses --without-system-readline --with-python=no"
PACKAGECONFIG_remove_mingw32 = "readline"
PACKAGECONFIG_remove_mingw32 = "python"

LDFLAGS_append_sdkmingw32 = " -Wl,-static"
EXEEXT_sdkmingw32 = ".exe"
DEPENDS_remove_sdkmingw32 = "nativesdk-ncurses nativesdk-readline nativesdk-python"
RDEPENDS_${PN}_remove_sdkmingw32 = "nativesdk-python-core nativesdk-python-lang nativesdk-python-re nativesdk-python-codecs nativesdk-python-netclient"
EXTRA_OECONF_append_sdkmingw32 = " --without-curses --without-system-readline --with-python=no"
PACKAGECONFIG_remove_sdkmingw32 = "readline"
PACKAGECONFIG_remove_sdkmingw32 = "python"
