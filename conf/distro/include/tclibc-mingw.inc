#
# glibc specific configuration
#
PREFERRED_PROVIDER_virtual/${TARGET_PREFIX}libc-for-gcc_mingw32 = "mingw-w64-runtime"
PREFERRED_PROVIDER_virtual/${TARGET_PREFIX}libc-initial_mingw32 = "mingw-w64-runtime"
PREFERRED_PROVIDER_virtual/libc = "mingw-w64-runtime"
PREFERRED_PROVIDER_virtual/libintl = "mingw-w64-runtime"
PREFERRED_PROVIDER_virtual/libiconv = "libiconv"
