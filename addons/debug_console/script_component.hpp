#define COMPONENT debug_console
#include "\z\afm\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_DEBUG_CONSOLE
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_DEBUG_CONSOLE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DEBUG_CONSOLE
#endif

#include "\z\afm\addons\main\script_macros.hpp"
