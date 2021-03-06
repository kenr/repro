# Copyright Tomas Zeman 2019.
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

function(clangformat_check_setup)
  if(NOT CLANGFORMAT_EXECUTABLE)
    set(CLANGFORMAT_EXECUTABLE clang-format)
  endif()

  if(NOT EXISTS ${CLANGFORMAT_EXECUTABLE})
    find_program(clangformat_executable_tmp ${CLANGFORMAT_EXECUTABLE} HINTS "C:/Program Files/LLVM/bin")
    if(clangformat_executable_tmp)
      set(CLANGFORMAT_EXECUTABLE ${clangformat_executable_tmp})
      unset(clangformat_executable_tmp)
    else()
      message(FATAL_ERROR "ClangFormat: ${CLANGFORMAT_EXECUTABLE} not found! Aborting")
    endif()
  endif()

  foreach(clangformat_source ${ARGV})
    get_filename_component(clangformat_source ${clangformat_source} ABSOLUTE)
    list(APPEND clangformat_sources ${clangformat_source})
  endforeach()

  add_custom_target(${PROJECT_NAME}_clangformat_check
    COMMAND
      ${CLANGFORMAT_EXECUTABLE}
      --style=file
      --output-replacements-xml
      ${clangformat_sources} > output-replacements.xml
    VERBATIM
    COMMAND ${CMAKE_COMMAND} -DREPLACEMENTS_FILE=${CMAKE_BINARY_DIR}/output-replacements.xml -P "${CMAKE_SOURCE_DIR}/cmake/CheckIfReplacements.cmake"
  )

  if(TARGET clangformat)
    add_dependencies(clangformat_check ${PROJECT_NAME}_clangformat_check)
  else()
    add_custom_target(clangformat_check DEPENDS ${PROJECT_NAME}_clangformat_check)
  endif()
endfunction()

function(target_clangformat_check_setup target)
  get_target_property(target_sources ${target} SOURCES)
  clangformat_check_setup(${target_sources})
endfunction()
