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

int main(int argc, char *argv[])
{
	uint8_t bytes[BUFSIZE];
	uint32_t *words = (uint32_t *) bytes;
	int i, len;

	if (argc < 2) {
		printf("Usage: %s regname\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	memset(bytes, 0, BUFSIZE);
	len = fread(bytes, 1, BUFSIZE - 4, stdin);
	if (len < 0) {
		perror("fread");
		exit(EXIT_FAILURE);
	}
	bytes[len] = 0x80;

	reverse_if_needed(bytes, len + 1);

	words[NUMWORDS - 1] = len;

	for (i = 0; i < NUMWORDS; i++)
		printf("%s[%d] = 32'h%08x;\n", argv[1], i, words[i]);

	return 0;
}
