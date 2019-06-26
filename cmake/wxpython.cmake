# wxPython
set(WXPYTHON_URL http://sourceforge.mirrorservice.org/w/wx/wxpython/wxPython/2.8.12.1/wxPython-src-2.8.12.1.tar.bz2)
set(WXPYTHON_HASH 8c06c5941477beee213b4f2fa78be620)
set(WXPYTHON_DIR ${CMAKE_CURRENT_BINARY_DIR}/wxpython)
set(WXPYTHON_INSTALL ${THIRD_PARTY_INSTALL_DIR}/wxpython)
set(WX_INSTALL ${THIRD_PARTY_INSTALL_DIR}/wxwidgets)
set(WXPYTHON_SRC ${WXPYTHON_DIR}/source)

ExternalProject_Add(wxpython
        URL ${WXPYTHON_URL}
        URL_MD5 ${WXPYTHON_HASH}
        PREFIX ${WXPYTHON_DIR}
        SOURCE_DIR ${WXPYTHON_SRC}
        INSTALL_DIR ${WX_INSTALL}
        PATCH_COMMAND
            patch --silent < ${PROJECT_SOURCE_DIR}/build/wxconfig.patch
        CONFIGURE_COMMAND
            sh ${WXPYTHON_SRC}/configure --prefix=${WX_INSTALL} --with-gtk --with-gnomeprint --with-opengl --enable-geometry --enable-graphics_ctx --enable-sound --with-sdl --enable-mediactrl --enable-display
        BUILD_COMMAND
            make &&
            make -C contrib/src/gizmos &&
            make -C contrib/src/stc
        INSTALL_COMMAND
            make install &&
            make -C contrib/src/gizmos install &&
            make -C contrib/src/stc install &&
            cd ${WXPYTHON_SRC}/wxPython &&
            export LD_LIBRARY_PATH=${WX_INSTALL}/lib:$ENV{LD_LIBRARY_PATH} &&
            export WXWIN=${WXPYTHON_SRC} &&
            export PATH=${WX_INSTALL}/bin:$ENV{PATH} &&
            export CFLAGS="-I${WX_INSTALL}/include/wx-2.8 $ENV{CFLAGS}" &&
            export CXXFLAGS="-I${WX_INSTALL}/include/wx-2.8 $ENV{CCFLAGS}" &&
            python setup.py build_ext --inplace UNICODE=0 BUILD_GLCANVAS=0 BUILD_OGL=0 &&
            python setup.py install UNICODE=0 --home=${WXPYTHON_INSTALL}
        )
set(WX_INCLUDE ${WX_INSTALL}/include/wx-2.8 ${WX_INSTALL}/lib/wx/include/gtk2-ansi-release-2.8)
set(WX_LIB_DIR ${WX_INSTALL}/lib)
set(WX_FLAGS -D_FILE_OFFSET_BITS=64 -D_LARGE_FILES -D__WXGTK__ -pthread)
set(WX_LIBRARIES -lwx_gtk2_adv-2.8 -lwx_gtk2_richtext-2.8 -lwx_gtk2_aui-2.8 -lwx_gtk2_xrc-2.8 -lwx_gtk2_qa-2.8 -lwx_gtk2_html-2.8  -lwx_gtk2_core-2.8 -lwx_base_xml-2.8 -lwx_base_net-2.8 -lwx_base-2.8 ewxaui)
