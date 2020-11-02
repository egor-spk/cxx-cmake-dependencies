# target: pugixml

include(FetchContent)

set(NAME "pugixml")
set(TAG "v1.10")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/zeux/pugixml.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR} EXCLUDE_FROM_ALL)
endif ()
