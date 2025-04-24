cmake_minimum_required(VERSION 4.0)

project(test)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")

# ==============================================================================
# 1. LOAD LLVM CONFIGURATION
# ==============================================================================
if(NOT DEFINED ENV{LLVM_DIR})
  message(FATAL_ERROR
    "LLVM installation directory variable LLVM_DIR not defined, "
    "export LLVM_DIR to /path/to/llvm/build")
endif()

list(APPEND CMAKE_PREFIX_PATH "$ENV{LLVM_DIR}/lib/cmake/llvm")

find_package(LLVM 15.0 REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in $ENV{LLVM_DIR}")

message(STATUS "LLVM STATUS:
  Definitions ${LLVM_DEFINITIONS}
  Includes    ${LLVM_INCLUDE_DIRS}
  Libraries   ${LLVM_LIBRARY_DIRS}
  Targets     ${LLVM_TARGETS_TO_BUILD}"
)

# ==============================================================================
# 2. BUILD CONFIGURATION
# ==============================================================================
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type:" FORCE)
endif()

set(CMAKE_CXX_STANDARD 17 CACHE STRING "CXX standard:")

set(CMAKE_CXX_FLAGS "-Wall")

if(NOT LLVM_ENABLE_RTTI)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

add_library(llvm_phony INTERFACE)
target_compile_definitions(llvm_phony INTERFACE ${LLVM_DEFINITIONS})
target_include_directories(llvm_phony INTERFACE ${LLVM_INCLUDE_DIRS})
target_link_directories(llvm_phony INTERFACE ${LLVM_LIBRARY_DIRS})
target_link_libraries(llvm_phony INTERFACE
  "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>")

# ==============================================================================
# 3. link to llvm phony target
# ==============================================================================

add_executable(test
  main.cpp
)

target_include_directories(test PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(test PRIVATE llvm_phony)
