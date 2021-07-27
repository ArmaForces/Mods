#define COMPONENT chat
#include "\z\afm\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CHAT
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_CHAT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CHAT
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define CHANNEL_GLOBAL 0
#define CHANNEL_SIDE 1
