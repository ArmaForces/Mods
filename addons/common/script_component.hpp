#define COMPONENT common
#include "\z\afm\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define COLOR_BCG { \
    "(profilenamespace getVariable ['GUI_BCG_RGB_R',0.13])", \
    "(profilenamespace getVariable ['GUI_BCG_RGB_G',0.54])", \
    "(profilenamespace getVariable ['GUI_BCG_RGB_B',0.21])", \
    "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.8])" \
}

#include "\z\afm\addons\main\script_macros.hpp"
