#include "../00_c_source_files/betray.h"
#include "../00_c_source_files/forge.h"
#include "../00_c_source_files/imagine.h"
#include "../00_c_source_files/seduce.h"

void seduce_tutorial_main_loop_func(BInputState *data, void *user_pointer) {}
int  main(int argc, char **argv)
{
    betray_init(B_CT_OPENGL, argc, argv, 800, 600, 4, FALSE, "Betray C11 Multiplatform Template");

    betray_action_func_set(seduce_tutorial_main_loop_func,
                           NULL); /* set a function pointer that will be the main loop of the app*/
    betray_launch_main_loop();    /* Start the main loop */
    return TRUE;
}
