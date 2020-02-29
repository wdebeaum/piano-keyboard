#ifndef _GPIO_H_
#define _GPIO_H_

#include <stdint.h>

extern volatile uint32_t *sets;
extern volatile uint32_t *clrs;
void setup_gpio();

#endif
