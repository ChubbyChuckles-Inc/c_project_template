#include "unity.h"

int unity_failures  = 0;
int unity_tests_run = 0;

int UNITY_BEGIN(void)
{
    unity_failures  = 0;
    unity_tests_run = 0;
    return 0;
}

int UNITY_END(void)
{
    if (unity_failures)
    {
        fprintf(stderr, "%d/%d tests failed\n", unity_failures, unity_tests_run);
    }
    else
    {
        fprintf(stdout, "%d tests passed\n", unity_tests_run);
    }
    return unity_failures;
}
