#include "test_helpers.h"

static uint32_t g_seed = 0x12345678u;

uint32_t drand_seed(uint32_t seed)
{
    g_seed = seed;
    return g_seed;
}

uint32_t drand_next(void)
{
    // xorshift32
    uint32_t x = g_seed;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    g_seed = x;
    return x;
}
