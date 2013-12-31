#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define BUFSIZE 64
#define NUMWORDS (BUFSIZE / 4)

static inline int is_little_endian(void)
{
	uint32_t testint = 1;
	uint8_t *testptr = (uint8_t *) &testint;

	if (*testptr == 1)
		return 1;
	return 0;
}

void reverse_if_needed(uint8_t *bytes, int count)
{
	uint8_t temp;
	int i;

	if (count % 4 != 0)
		// increase count to next multiple of 4
		count += 4 - (count % 4);

	if (!is_little_endian()) {
		for (i = 0; i < count; i += 4) {
			// swap 0 and 3
			temp = bytes[i];
			bytes[i] = bytes[i + 3];
			bytes[i + 3] = temp;
			// swap 1 and 2
			temp = bytes[i + 1];
			bytes[i + 1] = bytes[i + 2];
			bytes[i + 2] = temp;
		}
	}
}

int main(void)
{
	uint8_t bytes[BUFSIZE];
	uint32_t *words = (uint32_t *) bytes;
	int i, len;

	memset(bytes, 0, BUFSIZE);
	len = fread(bytes, 1, BUFSIZE - 4, stdin);
	if (len < 0) {
		perror("fread");
		exit(EXIT_FAILURE);
	}
	bytes[len] = 0x80;

	printf("Length: %d\n", len);

	printf("Actual: ");

	for (i = 0; i < len; i++)
		printf("%02x ", bytes[i]);
	printf("\n");

	reverse_if_needed(bytes, len);

	words[NUMWORDS - 1] = len;

	printf("Verilog: 512'h");

	for (i = NUMWORDS - 1; i >= 0; i--)
		printf("%08x", words[i]);
	printf("\n");

	return 0;
}
