#include "../../../include/project_api.h"
#include <stdio.h>
int main(void)
{
    if (project_init() != 0)
    {
        return 1;
    }
    printf("Network client stub\n");
    project_shutdown();
    return 0;
}
