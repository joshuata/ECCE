# THIRD PARTY PACKAGES
# set(THIRD_PARTY_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}) # TODO: Remove this line

# add_custom_target(third_party)
# add_dependencies(third_party xerces wxpython httpd)




# HTTPD
set(HTTPD_URL
    ${CMAKE_SOURCE_DIR}/build/3rdparty-dists/httpd-2.2.25.tar.bz2)
    #http://apache.mirrors.pair.com//httpd/httpd-2.2.34.tar.gz)
set(HTTPD_DIR ${CMAKE_CURRENT_BINARY_DIR}/httpd)
set(HTTPD_INSTALL ${THIRD_PARTY_INSTALL_DIR}/httpd)
set(HTTPD_SRC ${HTTPD_DIR}/source)

ExternalProject_Add(httpd
    URL ${HTTPD_URL}
    PREFIX ${HTTPD_DIR}
    SOURCE_DIR ${HTTPD_SRC}
    INSTALL_DIR ${HTTPD_INSTALL}
    CONFIGURE_COMMAND
        ${HTTPD_SRC}/configure --prefix=${HTTPD_INSTALL} --enable-rewrite --enable-dav
    BUILD_COMMAND
        make
    INSTALL_COMMAND
        make install
)

# ActiveMQ
#set(ACTIVEMQ_URL
#    https://github.com/FriendsofECCE/ECCE/raw/develop/build/3rdparty-dists/apache-activemq-5.1.0-bin.tar.bz2)
set(ACTIVEMQ_URL
    ${CMAKE_SOURCE_DIR}/build/3rdparty-dists/apache-activemq-5.1.0-bin.tar.bz2)
    #http://archive.apache.org/dist/activemq/apache-activemq/5.1.0/apache-activemq-5.1.0-bin.tar.gz)
set(ACTIVEMQ_DIR ${CMAKE_CURRENT_BINARY_DIR}/activemq)
set(ACTIVEMQ_INSTALL ${THIRD_PARTY_INSTALL_DIR}/activemq)
set(ACTIVEMQ_SRC ${ACTIVEMQ_DIR}/source)

ExternalProject_Add(activemq
    URL ${ACTIVEMQ_URL}
    PREFIX ${ACTIVEMQ_DIR}
    SOURCE_DIR ${ACTIVEMQ_INSTALL}
    CONFIGURE_COMMAND
        echo "It's a bin distrobution, so no build."
    BUILD_COMMAND
        echo "No build either."
    INSTALL_COMMAND
        echo "And no install."
)

install(DIRECTORY
        ${WXPYTHON_INSTALL}
        ${WX_INSTALL}
        ${XERCES_INSTALL}
    DESTINATION
        ${ECCE_APPS}/3rdparty)

install(DIRECTORY
        ${ACTIVEMQ_INSTALL}
        ${HTTPD_INSTALL}
    DESTINATION
        ${ECCE_SERVER})
