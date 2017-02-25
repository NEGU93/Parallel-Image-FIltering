cmake_minimum_required(VERSION 3.6)
project(Parallel_Image_FIltering)

set(CMAKE_CXX_STANDARD 11)

add_custom_target(mytest COMMAND make -C ${mytest_SOURCE_DIR}
                         CLION_EXE_DIR=${PROJECT_BINARY_DIR})
set(SOURCE_FILES
        include/gif_hash.h
        include/gif_lib.h
        include/gif_lib_private.h
        src/dgif_lib.c
        src/egif_lib.c
        src/gif_err.c
        src/gif_font.c
        src/gif_hash.c
        src/gifalloc.c
        src/main.c
        src/mainStatic.c
        src/openbsd-reallocarray.c
        src/quantize.c
        src/stats.c)

add_executable(Parallel_Image_FIltering ${SOURCE_FILES})
