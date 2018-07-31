#
# CMake toolchain file for targeting Apple Darwin (macOS, iOS, tvOS, watchOS, audioOS) x86_64 using LLVM/clang
# https://clang.llvm.org/docs/CrossCompilation.html
#

cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

if (NOT MK_TOOLCHAIN_PARSED)
	message(STATUS "Configuring using the LLVM x86_64 Darwin toolchain")
	set(MK_TOOLCHAIN_PARSED TRUE)
endif ()

# MK Settings
set(MK_TARGET_SYSTEM "Darwin")
set(MK_TARGET_PROCESSOR "x86_64")
set(MK_TARGET_TRIPLE "x86_64-apple-darwin")

include($ENV{MK_DIR}/cmake/toolchains/llvm.toolchain.cmake)
include($ENV{MK_DIR}/cmake/toolchains/cross.settings.cmake)

if (NOT ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	message(FATAL_ERROR "Using the macOS toolchain while the target platform is not macOS!")
endif ()

if (NOT ${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
	message(FATAL_ERROR "Using the x86_64 toolchain while the target processor is not x86_64!")
endif ()
