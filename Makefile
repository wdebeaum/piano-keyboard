CC=gcc
CFLAGS=
LDFLAGS=-lm -lpthread

GOAL = spi2midi
CFILES = gpio.c spi2midi.c
HFILES = wiring.h gpio.h
OFILES = $(CFILES:.c=.o)

$(GOAL): $(OFILES)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

%.o: %.c $(HFILES)
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f $(GOAL) $(OFILES)

