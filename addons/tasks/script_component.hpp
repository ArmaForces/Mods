#define COMPONENT tasks
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_TASKS
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_TASKS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TASKS
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define IF_PROPERTY_EXISTS(CONFIG,GET,DEFAULT) if (configName CONFIG isEqualTo "") then {DEFAULT} else {GET CONFIG}
