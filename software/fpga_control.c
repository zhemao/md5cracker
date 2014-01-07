#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "fpga_control.h"

#define PAGE_SIZE sysconf(_SC_PAGESIZE)

int init_fpga_control(struct fpga_control *fpga)
{
	void *map;

	fpga->fd = open(LWHPS2FPGA_DEVICE, O_RDWR);
	if (fpga->fd < 0)
		return -1;

	map = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
			MAP_SHARED, fpga->fd, 0);
	if (map == MAP_FAILED) {
		close(fpga->fd);
		return -1;
	}

	fpga->mem = (struct device_mem *) map;
	return 0;
}

void release_fpga_control(struct fpga_control *fpga)
{
	munmap(fpga->mem, PAGE_SIZE);
	close(fpga->fd);
}

void fpga_reset_unit(struct fpga_control *fpga, int unit)
{
	fpga->mem->md5control[0] |= (1 << unit);

	while ((fpga->mem->md5control[0] >> unit) & 0x1);
}

void fpga_start_unit(struct fpga_control *fpga, int unit)
{
	fpga->mem->md5control[1] |= (1 << unit);

	while ((fpga->mem->md5control[1] >> unit) & 0x1);
}

int fpga_unit_done(struct fpga_control *fpga, int unit)
{
	return (fpga->mem->md5control[2] >> unit) & 0x1;
}

void fpga_copy_input(struct fpga_control *fpga, uint32_t *input, int unit)
{
	int i, start;

	start = MD5_INPUT_SIZE * unit;

	for (i = 0; i < MD5_INPUT_SIZE; i++)
		fpga->mem->md5input[start + i] = input[i];
}
void fpga_copy_output(struct fpga_control *fpga, uint32_t *output, int unit)
{
	int i, start;

	start = MD5_OUTPUT_SIZE * unit;

	for (i = 0; i < MD5_OUTPUT_SIZE; i++)
		output[i] = fpga->mem->md5output[start + i];
}
