EXTRA_OECONF_append_mingw32 = "\
        --enable-term-driver \
        --enable-sp-funcs \
        cf_cv_working_poll=no \
"
EX_TERMLIB_mingw32 = "no"

do_install_mingw32() {
        # Order of installation is important; widec installs a 'curses.h'
        # header with more definitions and must be installed last hence.
        # Compatibility of these headers will be checked in 'do_test()'.
        oe_runmake -C narrowc ${_install_cfgs} ${_install_opts} \
                install.progs

        # The install.data should run after install.libs, otherwise
        # there would be a race issue in a very critical conditon, since
        # tic will be run by install.data, and tic needs libtinfo.so
        # which would be regenerated by install.libs.
        oe_runmake -C narrowc ${_install_cfgs} \
                install.data


        ! ${ENABLE_WIDEC} || \
            oe_runmake -C widec ${_install_cfgs} ${_install_opts}

        cd narrowc

        # include some basic terminfo files
        # stolen ;) from gentoo and modified a bit
        for x in ansi console dumb linux rxvt screen screen-256color sun vt52 vt100 vt102 vt200 vt220 xterm-color xterm-xfree86 xterm-256color
        do
                local termfile="$(find "${D}${datadir}/terminfo/" -name "${x}" 2>/dev/null)"
                local basedir="$(basename $(dirname "${termfile}"))"

                if [ -n "${termfile}" ]
                then
                        install -d ${D}${sysconfdir}/terminfo/${basedir}
                        mv ${termfile} ${D}${sysconfdir}/terminfo/${basedir}/
                        ln -s /etc/terminfo/${basedir}/${x} \
                                ${D}${datadir}/terminfo/${basedir}/${x}
                fi
        done
        # i think we can use xterm-color as default xterm
        if [ -e ${D}${sysconfdir}/terminfo/x/xterm-color ]
        then
                ln -sf xterm-color ${D}${sysconfdir}/terminfo/x/xterm
        fi

        # When changing ${libdir} to e.g. /usr/lib/myawesomelib/ ncurses
        # still installs '/usr/lib/terminfo', so try to rm both
        # the proper path and a slightly hardcoded one
        rm -f ${D}${libdir}/terminfo ${D}${prefix}/lib/terminfo

        # create linker scripts for libcurses.so and libncurses to
        # link against -ltinfo when needed. Some builds might break
        # else when '-Wl,--no-copy-dt-needed-entries' has been set in
        # linker flags.
        for i in libncurses libncursesw; do
                f=${D}${libdir}/$i.so
                test -h $f || continue
                rm -f $f
                echo '/* GNU ld script */'  >$f
                echo "INPUT(${i}5.dll AS_NEEDED(-ltinfo))" >>$f
        done

        # Make sure that libcurses is linked so that it gets -ltinfo
        # also, this should be addressed upstream really.
        ln -sf libncurses.dll ${D}${libdir}/libcurses.dll

        # create libtermcap.so linker script for backward compatibility
        f=${D}${libdir}/libtermcap.dll
        echo '/* GNU ld script */' >$f
        echo 'INPUT(AS_NEEDED(-ltinfo))' >>$f

        if [ ! -d "${D}${base_libdir}" ]; then
            # Setting base_libdir to libdir as is done in the -native
            # case will skip this code
            mkdir -p ${D}${base_libdir}
            mv ${D}${libdir}/libncurses.dll* ${D}${base_libdir}
            ! ${ENABLE_WIDEC} || \
                mv ${D}${libdir}/libncursesw.dll* ${D}${base_libdir}

        fi
        if [ -d "${D}${includedir}/ncurses" ]; then
            for f in `find ${D}${includedir}/ncurses -name "*.h"`
            do
                f=`basename $f`
                test -e ${D}${includedir}/$f && continue
                ln -sf ncurses/$f ${D}${includedir}/$f
            done
        fi
        oe_multilib_header curses.h
}

FILES_${PN} += "${bindir} ${libdir}"
