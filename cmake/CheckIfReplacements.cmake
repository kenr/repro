function(checkIfReplacements filename)
    if(NOT filename)
        message(ERROR "No filename provided for replacement file")
    endif()

    file(READ ${filename} REPLACEMENTS)
    string(FIND "${REPLACEMENTS}" "<replacement " FOUND_REPLACEMENTS)

    if (FOUND_REPLACEMENTS EQUAL -1)
        message(STATUS "No replacements found")
    else()
        message(FATAL_ERROR "Replacements found")        
    endif()
endfunction()

checkIfReplacements(${REPLACEMENTS_FILE})
