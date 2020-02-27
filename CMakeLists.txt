cmake_minimum_required(VERSION 3.12.4)

project(test-lib VERSION 0.0.0 LANGUAGES CXX C)
set(TEST_LIB "testlib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # For g++ this ensures -std=c++11 and not -std=gnu++11

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(ClangFormat)

message(STATUS "CMake version is ${CMAKE_VERSION}")

# On Windows, disable clang-tidy until arguments are fixed:
find_program(CLANG_TIDY_PATH NAMES clang-tidy-9 clang-tidy HINTS "C:/Program Files/LLVM/bin")

if(CLANG_TIDY_PATH)
    # Need to pass c++17 to clang-tidy as an extra argument from cmake to clang-tidy
    set(CMAKE_CXX_CLANG_TIDY  "${CLANG_TIDY_PATH};--extra-arg-before=-std=c++17")
    message(STATUS "clang-tidy linter found in directory ${CLANG_TIDY_PATH}")
    exec_program(${CLANG_TIDY_PATH} ARGS --version OUTPUT_VARIABLE clang_tidy_version)
    message(STATUS "clang-tidy version is ${clang_tidy_version}")
else()
    message(STATUS "clang-tidy not found, linting will not be done.")
endif()

find_program(CLANG_FORMAT_PATH clang-format)

if(CLANG_FORMAT_PATH)
    message(STATUS "clang-format found in directory ${CLANG_FORMAT_PATH}")
    exec_program(${CLANG_FORMAT_PATH} ARGS --version OUTPUT_VARIABLE clang_format_version)
    message(STATUS "clang-format version is ${clang_format_version}")
else()
    message(STATUS "clang-format not found")
endif()

add_library(${TEST_LIB}
    ${CMAKE_CURRENT_SOURCE_DIR}/lib.cpp
)

target_include_directories(${TEST_LIB} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_clangformat_setup(${TEST_LIB})

install(TARGETS ${TEST_LIB}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION bin
)
