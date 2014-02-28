cmake_minimum_required(VERSION 2.8)
project(greg)

set(sources greg.c compile.c tree.c)

if (NOT MSVC)
    add_definitions(-g -Wall -O3 -DNDEBUG)
else()
    add_subdirectory(wingetopt)
    include_directories(${CMAKE_CURRENT_LIST_DIR}/wingetopt/src)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE)
    # build as C++ for MSVC because C99 require VS2013+.
    set_source_files_properties(${sources} PROPERTIES LANGUAGE CXX)
endif()

add_executable(greg ${sources})

if (MSVC)
    target_link_libraries(greg wingetopt)
endif()

# grammar
get_target_property(greg_loc greg LOCATION)
set(greg_c "${CMAKE_CURRENT_LIST_DIR}/greg.c")
set(greg_g "${CMAKE_CURRENT_LIST_DIR}/greg.g")
add_custom_target(grammar COMMAND ${greg_loc} -o ${greg_c} ${greg_g})
