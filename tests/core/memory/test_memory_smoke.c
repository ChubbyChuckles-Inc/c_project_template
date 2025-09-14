#include "../../../include/project_api.h"
#include "../../unity/unity.h"

void setUp(void) {}
void tearDown(void) {}

void test_project_init_returns_zero(void) { TEST_ASSERT_EQUAL_INT(0, project_init()); }

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_project_init_returns_zero);
    return UNITY_END();
}
