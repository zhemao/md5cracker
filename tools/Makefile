CFLAGS=-Wall -O2

all: padandprint reference

padandprint: padandprint.c md5.o

reference: reference.c md5.o

%.o: %.c
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f padandprint
