cmake_minimum_required(VERSION 3.20)
cmake_policy(SET CMP0167 NEW)
project(student_container_template VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(ENABLE_TESTS "Build unit tests" ON)

add_library(container_interfaces INTERFACE)
target_include_directories(container_interfaces INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

if (MSVC)
    target_compile_options(container_interfaces INTERFACE /W4 /permissive-)
else()
    target_compile_options(container_interfaces INTERFACE -Wall -Wextra -Wpedantic)
endif()

if (ENABLE_TESTS)
    enable_testing()
    find_package(Boost REQUIRED COMPONENTS unit_test_framework)

    add_executable(container_tests
        tests/test_memory.cpp
    )

    target_link_libraries(container_tests
        PRIVATE
            container_interfaces
            Boost::unit_test_framework
    )

    add_test(NAME container_tests COMMAND container_tests)
endif()
