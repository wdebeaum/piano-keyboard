// USAGE:
// ./spi2midi >/dev/snd/midiC1D0

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#include "wiring.h"
#include "gpio.h"

int ioctl_or_die(int fd, unsigned long request, void* arg) {
  fprintf(stderr, "ioctl\n");
  int result = ioctl(fd, request, arg);
  if (result == -1) {
    perror("ioctl failed");
    exit(1);
  }
  return result;
}

// 30MHz clock (within spec for SN74HC165N)
#define MAX_SPEED_HZ 30000000
#define MAX_OCTAVES 10

int main(int argc, char** argv) {
  setup_gpio();
  // open the SPI device
  int fd = open(SPIDEV_PATH, O_RDONLY);
  if (fd == -1) {
    perror("failed to open spi device");
    exit(1);
  }
  // set SPI parameters
  char mode = 1; // clock pulses are positive, data read on falling edge
  ioctl_or_die(fd, SPI_IOC_WR_MODE, &mode);
  char bits_per_word = 8;
  ioctl_or_die(fd, SPI_IOC_WR_BITS_PER_WORD, &bits_per_word);
  uint32_t max_speed_hz = MAX_SPEED_HZ;
  ioctl_or_die(fd, SPI_IOC_WR_MAX_SPEED_HZ, &max_speed_hz);

  unsigned char buf[3];
  const int msg_len = 3;
  // the current state of each key switch (two per key, as 24 bits in each
  // octave, from C=(1<<{0,1}) to B=(1<<{22,23}); higher bit comes on first
  // when key is pressed)
  uint32_t switch_states[MAX_OCTAVES];
  memset(switch_states, 0, MAX_OCTAVES*sizeof(uint32_t));
  // the number of scans elapsed since the state of each switch changed
  unsigned char times_since_change[MAX_OCTAVES*24];
  memset(times_since_change, 0, MAX_OCTAVES*24);
  for(;;) {
    // get time at start of scan
    struct timespec now;
    if (clock_gettime(CLOCK_MONOTONIC, &now) == -1) {
      perror("error getting initial time");
      exit(1);
    }
    // parallel-load key states into shift registers
    *clrs = (1<<SH); // send SH/~LD pin low to LoaD
    // delay ~20ns (datasheet says min 14ns @4.5V VCC; each iteration ~1/25ns)
    int iters = 20 * 25;
    for (int i = 0; i < iters; i++)
      ;
    // serial-shift key states from shift registers to raspi, and interpret
    *sets = (1<<SH); // send SH/~LD pin high to SHift
    for (int o = 0; o < MAX_OCTAVES; o++) {
      int bytes_read = read(fd, buf, msg_len);
      if (bytes_read == -1) {
	perror("failed to read from spi device");
	exit(1);
      } else if (bytes_read < msg_len) {
	fprintf(stderr, "short read: %d out of %d bytes\n", bytes_read, msg_len);
      }
      // pullup resistor indicates end of octave chain
      if (buf[0] == 0xFF && buf[1] == 0xFF && buf[2] == 0xFF) {
	break;
      }
      uint32_t new_state =
        // force big-endian interpretation so that bits go in a consistent order
        ((uint32_t)buf[2])<<16 |
	((uint32_t)buf[1])<<8 |
	(uint32_t)buf[0];
      uint32_t old_state = switch_states[o];
      switch_states[o] = new_state;
      uint32_t changes = new_state ^ old_state;
      for (int s = 0; s < 24; s++, new_state >>= 1, changes >>= 1) {
	int tsci = o * 24 + s;
	if (changes & 1) { // switch changed state
	  // reset time since this switch changed state
	  times_since_change[tsci] = 0;
	// otherwise increment time since this switch changed state (clamped)
	} else if (times_since_change[tsci] < 0x80) {
	  times_since_change[tsci]++;
	  if (times_since_change[tsci] == 1 && s & 1 == 0) {
	    unsigned char note_num = (MAX_OCTAVES - 1 - o) * 12 + s/2;
	    // key-fully-down switch changed state last scan and stayed there
	    if (new_state & 1) { // key pressed
	      // get the time since the key-partly-down switch changed and use
	      // it to compute velocity
	      unsigned char velocity = 0x80 - times_since_change[tsci^1];
	      fprintf(stderr, "key %d in octave %d pressed with velocity %d\n",
	             s/2, o, (int)velocity);
	      buf[0] = 0x90;
	      buf[1] = note_num;
	      buf[2] = velocity;
	    } else { // key released
	      fprintf(stderr, "key %d in octave %d released\n", s/2, o);
	      buf[0] = 0x80;
	      buf[1] = note_num;
	      buf[2] = 0;
	    }
	    // emit MIDI event
	    int bytes_written = fwrite(buf, 1, 3, stdout);
	    if (bytes_written < 0) {
	      perror("failed to write midi event");
	      exit(1);
	    } else if (bytes_written != 3) {
	      fprintf(stderr, "short write of midi event\n");
	    }
	    if (fflush(stdout) != 0) {
	      perror("failed to flush midi event");
	      exit(1);
	    }
	  }
	}
      }
    }
    // delay until time for next scan, 128/44100ths of a second after start
    struct timespec later = now;
    unsigned long nsecs = now.tv_nsec + 2902494;
    later.tv_sec += nsecs / 1000000000;
    later.tv_nsec = nsecs % 1000000000;
    for(;;) {
      int err = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &later, NULL);
      if (err == 0) { // success
	break;
      } else if (err == EINTR) { // interrupted, try again
      } else { // some other error
        perror("error while nanosleeping");
	exit(1);
      }
    }
  }
  return 0;
}
