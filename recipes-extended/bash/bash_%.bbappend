EXTRA_OECONF_append_mingw32 = "\
    bash_cv_job_control_missing=nomissing \
    bash_cv_sys_named_pipes=nomissing \
    bash_cv_getcwd_malloc=yes \
    --without-libintl-prefix \
    --without-libiconv-prefix \
    --with-installed-readline \
    bash_cv_dev_stdin=present \
    bash_cv_dev_fd=standard \
    bash_cv_termcap_lib=libncurses \
    ac_cv_header_sys_resource_h=no \
    ac_cv_header_sys_wait_h=no \
"
