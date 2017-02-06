BIN= mandelbrot_seq \
	mandelbrot_gui_seq \
	mandelbrot_omp \
	mandelbrot_gui_omp

DISPLAY_CFLAGS=-DWITH_DISPLAY
DISPLAY_LDFLAGS= -lX11

all:$(BIN)

mandelbrot_seq: mandelbrot.c
	$(CC) -o $@ $< 

mandelbrot_omp: mandelbrot.c
	$(CC) -fopenmp -o $@ $< 

mandelbrot_gui_seq: mandelbrot.c
	$(CC) $(DISPLAY_CFLAGS) -o $@ $< $(DISPLAY_LDFLAGS)

mandelbrot_gui_omp: mandelbrot.c
	$(CC) -fopenmp $(DISPLAY_CFLAGS) -o $@ $< $(DISPLAY_LDFLAGS)

clean:
	rm -f $(BIN)
