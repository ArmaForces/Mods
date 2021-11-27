#define COMPONENT tasks
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_TASKS
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_TASKS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TASKS
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define DEFAULT_TITLE(TASK_NAME) "Task_TASK_NAME_Title"
#define DEFAULT_DESCRIPTION(TASK_NAME) "Task_TASK_NAME_Description"

#define FINISHED_TASK_STATES ["SUCCEEDED", "FAILED", "CANCELED"]
