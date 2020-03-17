#define COMPONENT insurgents
#include "\z\afm\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_INSURGENTS
    #define DEBUG_MODE_FULL
#endif
    #ifdef DEBUG_SETTINGS_INSURGENTS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_INSURGENTS
#endif

#include "\z\afm\addons\main\script_macros.hpp"

#define EMPTY_LOADOUT [[],[],[],[],[],[],"","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]

#define IS_DISPOSABLE(var) (cba_disposable_replaceDisposableLauncher && {!isNil {cba_disposable_NormalLaunchers getVariable var}})
#define RANDOM_GEAR(var) (GVAR(randomGear) getVariable [#var,[]])

#define CHANCE_HEADGEAR 0.5
#define CHANCE_FACEWEAR 0.3
#define CHANCE_PISTOL 0.3
#define CHANCE_LAUNCHER 0.1
