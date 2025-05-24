cmake_minimum_required(VERSION 3.10)

project(ConsolePrettyPrint VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_COMPILER "clang++")  

set(CMAKE_CXX_STANDARD 20)

file(GLOB SOURCES "${PROJECT_SOURCE_DIR}/src/*.cpp" "${PROJECT_SOURCE_DIR}/test/test.cpp")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)

add_executable(${EXECUTABLE_NAME} ${SOURCES})

target_compile_definitions(${EXECUTABLE_NAME} PRIVATE FMT_HEADER_ONLY)
target_include_directories(${EXECUTABLE_NAME} PRIVATE external)
target_include_directories(${EXECUTABLE_NAME} PRIVATE include)