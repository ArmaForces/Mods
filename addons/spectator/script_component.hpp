#define COMPONENT spectator
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_SPECTATOR
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_SPECTATOR
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SPECTATOR
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define IDC_COUNTER_BG 1002
#define IDC_GAMETIME 42609
#define IDC_TABS 43609
