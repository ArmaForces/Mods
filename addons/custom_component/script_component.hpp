#define COMPONENT custom_component
#include "\z\afm\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_CUSTOM_COMPONENT
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CUSTOM_COMPONENT
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CUSTOM_COMPONENT
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define COMPONENT_BG_IDC 15110
#define COMPONENT_BGGRP_IDC 15111
#define COMPONENT_TEXT_IDC 15112
#define COMPONENT_CONTENT_IDC 15113
