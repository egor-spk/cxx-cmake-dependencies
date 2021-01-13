# target: cpr::cpr

include(FetchContent)

set(NAME "cpr")
set(TAG "1.5.2")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/whoshuu/cpr.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "")
    set(BUILD_CPR_TESTS OFF CACHE INTERNAL "")
    set(USE_SYSTEM_CURL ON CACHE INTERNAL "")
    set(USE_OPENSSL OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()