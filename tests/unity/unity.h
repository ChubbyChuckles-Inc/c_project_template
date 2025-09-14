#ifndef UNITY_H
#define UNITY_H
#include <stdio.h>

int        UNITY_BEGIN(void);
int        UNITY_END(void);
extern int unity_failures;
extern int unity_tests_run;

#define TEST_ASSERT_EQUAL_INT(expected, actual)                                                    \
    do                                                                                             \
    {                                                                                              \
        if ((expected) != (actual))                                                                \
        {                                                                                          \
            fprintf(stderr, "ASSERT FAIL: expected %d got %d\n", (expected), (actual));            \
            unity_failures++;                                                                      \
        }                                                                                          \
    } while (0)

#define RUN_TEST(fn)                                                                               \
    do                                                                                             \
    {                                                                                              \
        extern void setUp(void);                                                                   \
        extern void tearDown(void);                                                                \
        setUp();                                                                                   \
        fn();                                                                                      \
        unity_tests_run++;                                                                         \
        tearDown();                                                                                \
    } while (0)

#endif
