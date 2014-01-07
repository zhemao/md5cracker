#include <stdlib.h>
#include <stdio.h>
#include "fpga_control.h"
#include "md5.h"

/* cycle through the units until you find one that's free */
int find_available_unit(struct fpga_control *fpga)
{
	int i;

	for (i = 0; i < NUM_MD5_UNITS; i++) {
		if (fpga_unit_done(fpga, i))
			return i;
	}

	return -1;
}

void print_digest(uint32_t *digest)
{
	int i, j;
	uint8_t byte;

	for (i = 0; i < 4; i++) {
		for (j = 0; j < 4; j++) {
			byte = (digest[i] >> (8 * j)) & 0xff;
			printf("%02x", byte);
		}
	}
	printf("\n");
}

int main(void)
{
	int unit, len, status = 0;
	struct fpga_control fpga[1];
	uint8_t bytes[BUFSIZE];
	uint32_t digest[4];
	uint32_t *words = (uint32_t *) bytes;

	if (init_fpga_control(fpga)) {
		fprintf(stderr, "Could not initialize fpga controller\n");
		exit(EXIT_FAILURE);
	}

	len = fread(bytes, 1, BUFSIZE - 5, stdin);
	if (len < 0) {
		perror("fread");
		status = EXIT_FAILURE;
		goto cleanup;
	}

	padbuffer(bytes, len);

	unit = find_available_unit(fpga);
	if (unit < 0) {
		fprintf(stderr, "Could not get available FPGA unit\n");
		status = EXIT_FAILURE;
		goto cleanup;
	}

	printf("resetting\n");
	fpga_reset_unit(fpga, unit);
	printf("copying input\n");
	fpga_copy_input(fpga, words, unit);
	printf("starting\n");
	fpga_start_unit(fpga, unit);

	printf("waiting for completion\n");
	while (!fpga_unit_done(fpga, unit));

	printf("copying output\n");
	fpga_copy_output(fpga, digest, unit);
	print_digest(digest);

cleanup:
	release_fpga_control(fpga);
	return status;
}
