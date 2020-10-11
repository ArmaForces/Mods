#define COMPONENT loading
#include "\z\afm\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_LOADING
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_LOADING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOADING
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define IDC_LOADINGSTART_CUSTOM_BG 657001
