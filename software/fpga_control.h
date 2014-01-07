#ifndef __FPGA_CONTROL__
#define __FPGA_CONTROL__

#define LWHPS2FPGA_DEVICE "/dev/lwhps2fpga0"
#define NUM_MD5_UNITS 32
#define MD5_INPUT_SIZE 16
#define MD5_OUTPUT_SIZE 4

#include <stdint.h>

struct device_mem {
	uint32_t md5input[512];
	uint32_t md5output[128];
	uint32_t md5control[3];
};

struct fpga_control {
	struct device_mem *mem;
	int fd;
};

int init_fpga_control(struct fpga_control *fpga);
void release_fpga_control(struct fpga_control *fpga);

void fpga_reset_unit(struct fpga_control *fpga, int unit);
void fpga_start_unit(struct fpga_control *fpga, int unit);
int fpga_unit_done(struct fpga_control *fpga, int unit);
void fpga_copy_input(struct fpga_control *fpga, uint32_t *input, int unit);
void fpga_copy_output(struct fpga_control *fpga, uint32_t *output, int unit);

#endif
