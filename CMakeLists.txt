cmake_minimum_required(VERSION 3.12.4)

project(test-lib VERSION 0.0.0 LANGUAGES CXX C)
set(TEST_LIB "testlib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # For g++ this ensures -std=c++11 and not -std=gnu++11

add_library(${TEST_LIB}
    ${CMAKE_CURRENT_SOURCE_DIR}/lib.cpp
)

target_include_directories(${TEST_LIB} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

install(TARGETS ${TEST_LIB}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION bin
)
