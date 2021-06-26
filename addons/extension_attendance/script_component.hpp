#define COMPONENT extension_attendance
#include "\z\afm\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_EXTENSION_ATTENDANCE
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_EXTENSION_ATTENDANCE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_EXTENSION_ATTENDANCE
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define ATTENDANCE_DELAY_MIN 30

#define IS_ATTENDANCE_LOGGED(ID) (missionNamespace getVariable [format [QGVAR(logged$%1), ID], false])
#define SET_ATTENDANCE_LOGGED(ID) (missionNamespace setVariable [format [QGVAR(logged$%1), ID], true, true])
