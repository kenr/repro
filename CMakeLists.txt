cmake_minimum_required(VERSION 3.12.4)

if(DEFINED ENV{VCPKG_ROOT} AND NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
else()
	message(FATAL "VCPKG_ROOT not set")
endif()

project(test-lib VERSION 0.0.0 LANGUAGES CXX C)
set(TEST_LIB "nrfdl")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

find_package(Threads REQUIRED)
find_package(spdlog CONFIG REQUIRED)
find_package(fmt CONFIG REQUIRED)
find_package(Catch2 CONFIG REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # For g++ this ensures -std=c++11 and not -std=gnu++11

# Compiler specific
#if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "MSVC")
#    include(cmake/msvc.cmake)
#endif()

#find_program(CLANG_TIDY_PATH NAMES clang-tidy-9 clang-tidy)

if(CLANG_TIDY_PATH)
    # Need to pass c++17 to clang-tidy as an extra argument from cmake to clang-tidy
    set(CMAKE_CXX_CLANG_TIDY  "${CLANG_TIDY_PATH};--extra-arg-before=-std=c++17")
    message(STATUS "clang-tidy linter found in directory ${CLANG_TIDY_PATH}")
else()
    message(STATUS "clang-tidy linter not found, linting will not be done.")
endif()

add_library(${TEST_LIB}
    ${CMAKE_CURRENT_SOURCE_DIR}/lib.cpp
)

target_include_directories(${TEST_LIB} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(${TEST_LIB} PRIVATE -DSPDLOG_HEADER_ONLY)

target_link_libraries(${TEST_LIB}
    PRIVATE
        spdlog::spdlog
)

install(TARGETS ${TEST_LIB}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION bin
)
