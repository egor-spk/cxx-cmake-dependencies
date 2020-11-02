# target: snmp

include(ExternalProject)

set(SNMP_INST_DIR "${FETCHCONTENT_BASE_DIR}/snmp++build")
set(SNMPXX_VER "3.3.11a")
set(AGENTXX_VER "4.1.2")
set(SNMPXX_LIB_NAME "snmp++")
set(AGENTXX_LIB_NAME "agent++")
set(SNMPXX_LIB "lib${SNMPXX_LIB_NAME}.a")
set(AGENTXX_LIB "lib${AGENTXX_LIB_NAME}.a")

ExternalProject_Add(snmpxx
                    PREFIX ${SNMP_INST_DIR}
                    INSTALL_DIR ${SNMP_INST_DIR}
                    URL https://agentpp.com/download/snmp++-${SNMPXX_VER}.tar.gz
                    SOURCE_DIR ${FETCHCONTENT_BASE_DIR}/snmp++src
                    UPDATE_COMMAND ""
                    CONFIGURE_COMMAND <SOURCE_DIR>/configure
                     --enable-static --disable-shared --disable-debug
                     --disable-logging --prefix=<INSTALL_DIR>
                    BUILD_IN_SOURCE 1
                    LOG_CONFIGURE 1
                    LOG_BUILD 1
                    LOG_INSTALL 1)
set_target_properties(snmpxx PROPERTIES EXCLUDE_FROM_ALL TRUE)

ExternalProject_Add(agentxx
                    PREFIX ${SNMP_INST_DIR}
                    INSTALL_DIR ${SNMP_INST_DIR}
                    DEPENDS snmpxx
                    URL https://agentpp.com/download/agent++-${AGENTXX_VER}.tar.gz
                    SOURCE_DIR ${FETCHCONTENT_BASE_DIR}/agent++src
                    UPDATE_COMMAND ""
                    CONFIGURE_COMMAND <SOURCE_DIR>/configure
                     --enable-static --disable-shared
                     --disable-debug --prefix=<INSTALL_DIR>
                    BUILD_IN_SOURCE 1
                    LOG_CONFIGURE 1
                    LOG_BUILD 1
                    LOG_INSTALL 1)
set_target_properties(agentxx PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_definitions("-D_SNMPv3")

set(SNMP_LIB_DIR "${SNMP_INST_DIR}/lib/")
link_directories(${SNMP_LIB_DIR})

set(SNMPXX_USE_STATIC_LIBS ON)
set(SNMPXX_INCLUDE_DIR "${SNMP_INST_DIR}/include/snmp_pp")
set(SNMPXX_LIBRARY "${SNMP_INST_DIR}/lib/${SNMPXX_LIB}")

set(AGENTXX_USE_STATIC_LIBS ON)
set(AGENTXX_INCLUDE_DIR "${SNMP_INST_DIR}/include/agent_pp")
set(AGENTXX_LIBRARY "${SNMP_INST_DIR}/lib/${AGENTXX_LIB}")

set(SNMP_INCLUDE_DIR "${SNMP_INST_DIR}/include")
set(SNMP_LIBS ${AGENTXX_LIBRARY} ${SNMPXX_LIBRARY} rt crypto ssl)

add_library(snmp INTERFACE)
target_include_directories(snmp INTERFACE ${SNMPXX_INCLUDE_DIR} ${AGENTXX_INCLUDE_DIR} ${SNMP_INCLUDE_DIR})
target_link_libraries(snmp INTERFACE ${SNMPXX_LIBRARY} ${AGENTXX_LIBRARY} ${SNMP_LIBS})
add_dependencies(snmp snmpxx agentxx)