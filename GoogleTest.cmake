# target: gmock_main or gtest_main or gtest or gmock

include(FetchContent)

set(NAME "gtest")
set(TAG "master")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(INSTALL_GTEST OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()