#ifndef PROJECT_API_H
#define PROJECT_API_H

#include "project_config.h"

#ifdef __cplusplus
extern "C"
{
#endif

    int  project_init(void);
    void project_shutdown(void);

#ifdef __cplusplus
}
#endif

#endif // PROJECT_API_H
