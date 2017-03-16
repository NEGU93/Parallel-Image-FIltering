SRC_DIR=src
HEADER_DIR=include
OBJ_DIR=obj

CC=nvcc
CFLAGS=-O3 -I$(HEADER_DIR) -Xcompiler -fopenmp -I/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/include
LDFLAGS=-lm -L/users/profs/2016/francois.trahay/soft/install/openmpi-2.0.1/lib -lmpi

SRC= dgif_lib.c \
	egif_lib.c \
	gif_err.c \
	gif_font.c \
	gif_hash.c \
	gifalloc.c \
	cudaKernel.cu \
	parallelSplitMPI.cu	\
	main.cu \
	openbsd-reallocarray.c \
	quantize.c


OBJ= $(OBJ_DIR)/dgif_lib.o \
	$(OBJ_DIR)/egif_lib.o \
	$(OBJ_DIR)/gif_err.o \
	$(OBJ_DIR)/gif_font.o \
	$(OBJ_DIR)/gif_hash.o \
	$(OBJ_DIR)/gifalloc.o \
	$(OBJ_DIR)/cudaKernel.o \
	$(OBJ_DIR)/parallelSplitMPI.o	\
	$(OBJ_DIR)/main.o \
	$(OBJ_DIR)/openbsd-reallocarray.o \
	$(OBJ_DIR)/quantize.o


all: $(OBJ_DIR) sobelf

$(OBJ_DIR):
	mkdir $(OBJ_DIR)

$(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $^


$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cu
	$(CC) $(CFLAGS) -c -I/usr/local/cuda/include -I. -o $@ $^ -I/usr/local/cuda/samples/0_Simple/simplePrintf/

sobelf:$(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -L/usr/local/cuda/lib

clean:
	rm -f sobelf $(OBJ)
