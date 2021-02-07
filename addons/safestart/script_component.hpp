#define COMPONENT safestart
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_SAFESTART
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_SAFESTART
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SAFESTART
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define MISSION_DISPLAY (findDisplay 46)
