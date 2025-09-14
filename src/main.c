#include "project_api.h"
#include "project_config.h"

/* MergeSource headers are provided via include path; include as needed */
#include "forge.h"

int project_init(void)
{
    /* Initialize any required MergeSource systems lazily in app code later */
    return 0;
}

void project_shutdown(void) {}

int main(void)
{
    (void) PROJECT_NAME; /* prevent unused warnings */
    (void) PROJECT_VERSION_MAJOR;
    project_init();
    /* Placeholder: app code */
    project_shutdown();
    return 0;
}
