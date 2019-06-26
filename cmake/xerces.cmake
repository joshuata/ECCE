# XERCES
#set(XERCES_REPO
set(XERCES_URL http://archive.apache.org/dist/xerces/c/2/sources/xerces-c-src_2_8_0.tar.gz)
set(XERCES_HASH 5daf514b73f3e0de9e3fce704387c0d2)
set(XERCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/xerces)
set(XERCES_INSTALL ${THIRD_PARTY_INSTALL_DIR}/xerces)
set(XERCES_ROOT ${XERCES_DIR}/source)
set(XERCES_SRC ${XERCES_ROOT}/src/xercesc)

IF(APPLE)
    set(XERCES_PLATFORM macosx)
ELSE(APPLE)
    set(XERCES_PLATFORM linux)
ENDIF(APPLE)

ExternalProject_Add(xerces
        URL ${XERCES_URL}
        URL_MD5 ${XERCES_HASH}
        PREFIX ${XERCES_DIR}
        INSTALL_DIR ${XERCES_INSTALL}
        SOURCE_DIR ${XERCES_ROOT}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND
        # Build steps lumped together because XercesC environment variables
        # Using bash script prevents rebuilding if .installed file exists
        # I dislike this, but...
        sh ${CMAKE_SOURCE_DIR}/cmake/build_xerces.sh ${XERCES_SRC} ${XERCES_ROOT} ${XERCES_INSTALL} ${XERCES_PLATFORM}
        )
set(XERCES_INCLUDE ${XERCES_INSTALL}/include)
set(XERCES_LIB_DIR ${XERCES_INSTALL}/lib)
set(XERCES_LIBRARIES -lxerces-c -lxerces-depdom)