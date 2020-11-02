# target: restinio

include(ExternalProject)

set(RESTINIO_VER "0.6.10")
set(RESTINIO_SRC_DIR "${FETCHCONTENT_BASE_DIR}/restinio-src")
set(RESTINIO_INST_DIR "${FETCHCONTENT_BASE_DIR}/restinio-build")

ExternalProject_Add(stiffstream-restinio
        PREFIX ${RESTINIO_INST_DIR}
        INSTALL_DIR ${RESTINIO_INST_DIR}
        URL https://github.com/Stiffstream/restinio/releases/download/v.${RESTINIO_VER}/restinio-${RESTINIO_VER}-full.tar.bz2
        SOURCE_DIR ${RESTINIO_SRC_DIR}
        UPDATE_COMMAND ""
        CONFIGURE_COMMAND cmake -DRESTINIO_TEST=OFF -DRESTINIO_SAMPLE=OFF -DRESTINIO_BENCH=OFF <SOURCE_DIR>/dev
        INSTALL_COMMAND ""
        BUILD_IN_SOURCE TRUE
        EXCLUDE_FROM_ALL TRUE
        LOG_CONFIGURE TRUE
        LOG_BUILD TRUE
        LOG_INSTALL TRUE)

if (USE_INTERNAL_FMTLIB)
    set(FMT_LIB "libfmt.a")
    set(FMT_LIBRARY "${RESTINIO_SRC_DIR}/fmt/${FMT_LIB}")
    set(FMT_INCLUDE_DIR "${RESTINIO_SRC_DIR}/dev/fmt/include")
endif ()
set(HTTP_PARSER_LIB "libhttp_parser.a")
set(HTTP_PARSER_LIBRARY "${RESTINIO_SRC_DIR}/nodejs/http_parser/${HTTP_PARSER_LIB}")
set(RESTINIO_INCLUDE_DIR "${RESTINIO_SRC_DIR}/dev/restinio")
set(ASIO_INCLUDE_DIR "${RESTINIO_SRC_DIR}/dev/asio/include")
set(HTTP_PARSER_INCLUDE_DIR "${RESTINIO_SRC_DIR}/dev/nodejs/http_parser")

set(RESTINIO_INCLUDE_DIR ${ASIO_INCLUDE_DIR} ${HTTP_PARSER_INCLUDE_DIR} "${RESTINIO_SRC_DIR}/dev")
set(RESTINIO_LIBS ${HTTP_PARSER_LIBRARY})

if (USE_INTERNAL_FMTLIB)
    set(RESTINIO_INCLUDE_DIR ${RESTINIO_INCLUDE_DIR} ${FMT_INCLUDE_DIR})
    set(RESTINIO_LIBS ${RESTINIO_LIBS} ${FMT_LIBRARY})
endif ()

add_definitions(-DASIO_STANDALONE -DASIO_HAS_STD_CHRONO)

add_library(restinio INTERFACE)
target_include_directories(restinio INTERFACE ${RESTINIO_INCLUDE_DIR})
target_link_libraries(restinio INTERFACE ${RESTINIO_LIBS})
add_dependencies(restinio stiffstream-restinio)
