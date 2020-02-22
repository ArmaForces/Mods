#define COMPONENT respawn
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_RESPAWN
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_RESPAWN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_RESPAWN
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define TIME_DISABLED 1e10
#define TIME_MINIMUM 1
