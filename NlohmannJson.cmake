# target: nlohmann_json::nlohmann_json

include(FetchContent)

set(NAME "json")
set(TAG "v3.9.1")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/nlohmann/json.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    set(JSON_BuildTests OFF CACHE INTERNAL "")
    set(JSON_Install OFF CACHE INTERNAL "")

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()