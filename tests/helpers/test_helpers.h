#ifndef TEST_HELPERS_H
#define TEST_HELPERS_H

#include <stdint.h>

uint32_t drand_seed(uint32_t seed);
uint32_t drand_next(void);

void assert_memory_no_leak(void);

#endif
