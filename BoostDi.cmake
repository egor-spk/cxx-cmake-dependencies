# target: Boost.DI

include(FetchContent)

set(NAME "boost_di")
set(TAG "v1.2.0")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/boost-experimental/di.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(BOOST_DI_OPT_BUILD_TESTS OFF CACHE INTERNAL "")
    set(BOOST_DI_OPT_BUILD_EXAMPLES OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()