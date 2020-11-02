# requires installed libzmq
# target: cppzmq

include(FetchContent)

set(NAME "cppzmq")
set(TAG "v4.4.1")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/zeromq/cppzmq.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(CPPZMQ_BUILD_TESTS OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()