# requires installed libgumbo-dev
# target: gumbo_query_shared or gumbo_query_static

include(FetchContent)

set(NAME "gumbo-query")
set(TAG "master")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/lazytiger/gumbo-query.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
    set_target_properties(gumbo_query_shared PROPERTIES INCLUDE_DIRECTORIES ${${lcName}_SOURCE_DIR}/src)    
    set_target_properties(gumbo_query_static PROPERTIES INCLUDE_DIRECTORIES ${${lcName}_SOURCE_DIR}/src)
endif ()