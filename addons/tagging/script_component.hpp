#define COMPONENT tagging
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_TAGGING
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_TAGGING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TAGGING
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define MARKER_COLORS   ["ColorRed", "ColorGreen", "ColorBlue", "ColorBlack", "ColorYellow", "ColorWhite"]
#define TEXTURE_COLORS  ["red", "green", "blue", "black", "yellow", "white"]
