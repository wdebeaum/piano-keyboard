CC=gcc
CFLAGS=
LDFLAGS=-lm -lpthread

GOAL = spi2midi
CFILES = gpio.c spi2midi.c
HFILES = wiring.h gpio.h
OFILES = $(CFILES:.c=.o)
DOCS = README.html BOM.html BUILD.html USAGE.html

$(GOAL): $(OFILES)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

%.o: %.c $(HFILES)
	$(CC) -c $(CFLAGS) $<

docs: $(DOCS)

%.html: %.md
	markdown_py -f $@ -e utf-8 -x tables $<

clean:
	rm -f $(GOAL) $(OFILES) $(DOCS)

