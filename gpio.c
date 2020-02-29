#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "wiring.h"
#include "gpio.h"

//
// base for these offsets is bus address 0x7e000000, but layers of translation
// between us and the bus mean that we must get our version of that base from
// mmap'ing /dev/gpiomem
//

// 6 32 bit words, each containing 10 groups of 3 bits: 000 means the
// corresponding pin is an input; 001 means it's an output; other values are
// for special functions specific to the pin
#define MODES_OFFSET 0x00200000
// writing to one of the two 32 bit words at this offset will cause gpio pins
// to go high corresponding to the 1s in the written word (it will not cause
// any gpio pins to go low)
#define SETS_OFFSET 0x0020001C
// reverse of the above: writing causes some pins to go low, but won't cause
// any to go high
#define CLRS_OFFSET 0x00200028

// mmap a page at a time (that's what wiringpi does, why change it?)
#define BLOCK_SIZE 4096

static volatile uint32_t *modes;
volatile uint32_t *sets;
volatile uint32_t *clrs;
int gpiomem_fd;

// like mmap, but with all the extra parameters built in, and able to map
// memory not aligned to a page boundary
uint32_t* my_mmap(off_t offset) {
  off_t page_offset = offset & ~0xfff;
  off_t addend = (offset & 0xfff) >> 2;
  uint32_t* page_ptr = (uint32_t*)mmap(NULL, BLOCK_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, gpiomem_fd, page_offset);
  return page_ptr + addend;
}

// memcpy doesn't work for volatiles
void my_memcpy32(volatile uint32_t* dst, volatile uint32_t* src, size_t n) {
  for (size_t i = 0; i < n; i++) {
    dst[i] = src[i];
  }
}

void setup_gpio() {
  // open GPIO memory area device
  gpiomem_fd = open("/dev/gpiomem", O_RDWR | O_SYNC | O_CLOEXEC);
  if (gpiomem_fd == -1) {
    perror("failed to open /dev/gpiomem");
    exit(1);
  }
  // map the parts of that memory that we need
  modes = my_mmap(MODES_OFFSET);
  sets = my_mmap(SETS_OFFSET);
  clrs = my_mmap(CLRS_OFFSET);
  if (modes == MAP_FAILED || sets == MAP_FAILED || clrs == MAP_FAILED) {
    perror("mmap failed");
    exit(1);
  }
  // read modes into my_modes
  uint32_t my_modes[6];
  my_memcpy32(my_modes, modes, 6);
  // modify my_modes
  // (this is a bit elaborate for setting the mode of one pin; code is from
  // opl2)
//#define input_mode 0
#define output_mode 1
#define mode_mask ((uint32_t)7)
#define set_mode(pin, mode) { \
  int word = (pin) / 10; \
  int shift = ((pin) % 10) * 3; \
  my_modes[word] = (my_modes[word] & (~(mode_mask<<shift))) | (mode<<shift); \
}
  set_mode(SH, output_mode);
#undef set_mode
#undef mode_mask
#undef output_mode
  // write my_modes back to modes
  my_memcpy32(modes, my_modes, 6);
}

