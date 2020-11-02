# target: multipart-parser-c

include(FetchContent)

set(NAME "multipart-parser-c")
set(TAG "origin/fix-boundary-parse")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/egor-spk/multipart-parser-c.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    add_library(multipart-parser-c INTERFACE)
    option(DEBUG_MULTIPART "View console output" OFF)
    if (DEBUG_MULTIPART)
        target_compile_definitions(multipart-parser-c INTERFACE DEBUG_MULTIPART)
    endif ()
    target_include_directories(multipart-parser-c
            INTERFACE
            $<BUILD_INTERFACE:${${lcName}_SOURCE_DIR}>)
    target_sources(multipart-parser-c
            INTERFACE
            $<BUILD_INTERFACE:${${lcName}_SOURCE_DIR}/multipart_parser.c>)
endif ()