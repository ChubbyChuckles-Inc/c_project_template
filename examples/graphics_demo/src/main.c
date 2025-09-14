#include "../../../include/project_api.h"
#include <stdio.h>
int main(void)
{
    if (project_init() != 0)
    {
        return 1;
    }
    printf("Graphics demo stub\n");
    project_shutdown();
    return 0;
}
