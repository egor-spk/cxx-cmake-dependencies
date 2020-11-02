# target: flatbuffers

include(FetchContent)

set(NAME "flatbuffers")
set(TAG "v1.12.0")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/google/flatbuffers.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(FLATBUFFERS_BUILD_TESTS OFF CACHE INTERNAL "")
    set(FLATBUFFERS_INSTALL OFF CACHE INTERNAL "")
    set(FLATBUFFERS_LIBCXX_WITH_CLANG OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()