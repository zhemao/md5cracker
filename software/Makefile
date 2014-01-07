CFLAGS=-Wall -O2

hwmd5sum: hwmd5sum.c fpga_control.o md5.o

tools: padandprint reference

padandprint: padandprint.c md5.o

reference: reference.c md5.o

%.o: %.c
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f padandprint reference hwmd5sum *.o
