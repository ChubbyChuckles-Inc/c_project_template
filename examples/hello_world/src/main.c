#include "../../../include/project_api.h"
#include <stdio.h>

int main(void)
{
    if (project_init() != 0)
    {
        fprintf(stderr, "Initialization failed\n");
        return 1;
    }
    printf("Hello, C11 Multiplatform Template!\n");
    project_shutdown();
    return 0;
}
