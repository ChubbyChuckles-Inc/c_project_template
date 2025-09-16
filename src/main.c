#include "../00_c_source_files/betray.h"
#include "../00_c_source_files/forge.h"
#include "../00_c_source_files/imagine.h"
#include "../00_c_source_files/relinquish.h"
#include "../00_c_source_files/seduce.h"

void seduce_tutorial_main_loop_func(BInputState *input, void *user_pointer)
{
    RMatrix matrix;
    if (input->mode == BAM_DRAW)
    {
        r_matrix_identity(&matrix);
        r_matrix_frustum(&matrix, -0.01, 0.01, -0.01, 0.01, 0.01, 100.0);
        r_matrix_set(&matrix);
    }

    if(input->mode == BAM_EVENT)
    {
        r_matrix_set(NULL);
    }
}

int main(int argc, char **argv)
{
    uint x_size, y_size;
    imagine_settings_load("seduce_tutorial.txt"); /* loads all settings from a file */
    betray_init(
        B_CT_OPENGL, argc, argv,
        imagine_setting_integer_get("SCREEN_RES_X", 640, "This value represents the window_width"),
        imagine_setting_integer_get("SCREEN_RES_Y", 480, "This value represents the window_height"),
        4, FALSE, "Betray C11 Multiplatform Template");

    r_init(betray_gl_proc_address_get()); /* r_init initializes Relinquish and returns TRUE if it
                                             sucseeds and FAIL if it fails */

    betray_action_func_set(seduce_tutorial_main_loop_func,
                           NULL); /* set a function pointer that will be the main loop of the app*/
    betray_launch_main_loop();    /* Start the main loop */
    betray_screen_mode_get(
        &x_size, &y_size,
        NULL); /* Get the current screen size, and if it is in fullscreen. Any pameters can be set
                  to NULL, if you are not interested in any parameter. The fuinction returns the
                  aspect ratio of the window/display*/
    imagine_setting_integer_set("SCREEN_RES_X", x_size, "This value represents the window_width");
    imagine_setting_integer_set("SCREEN_RES_Y", y_size, "This value represents the window_height");
    imagine_settings_save("seduce_tutorial.txt"); /* saves all settings to a file */
    return TRUE;
}
