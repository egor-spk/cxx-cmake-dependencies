# target: jsonrpcpp

include(FetchContent)

set(NAME "jsonrpcpp")
set(TAG "master")

FetchContent_Declare(${NAME}
        GIT_REPOSITORY https://github.com/badaix/jsonrpcpp.git
        GIT_TAG ${TAG}
        )

FetchContent_GetProperties(${NAME})
string(TOLOWER ${NAME} lcName)
if (NOT ${lcName}_POPULATED)
    FetchContent_Populate(${NAME})

    add_library(jsonrpcpp INTERFACE)
    target_include_directories(jsonrpcpp
            INTERFACE
            $<BUILD_INTERFACE:${${lcName}_SOURCE_DIR}/include/>)
endif ()