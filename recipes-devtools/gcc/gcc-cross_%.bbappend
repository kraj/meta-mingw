EXTRA_OECONF_remove_mingw32 = "--with-linker-hash-style=${LINKER_HASH_STYLE}"
PACKAGECONFIG_CONFARGS ?= ""
EXTRA_OECONF_remove_mingw32 = "--enable-initfini-array"
EXTRA_OECONF_append_mingw32 = " --disable-initfini-array"
