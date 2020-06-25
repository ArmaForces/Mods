#define COMPONENT main_menu
#include "\z\afm\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN_MENU
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_MAIN_MENU
    #define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN_MENU
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define MP_PWD_BORDER_CONTROL (_display displayCtrl ([108, 143] select (_displayName == 'RscDisplayRemoteMissions')))
