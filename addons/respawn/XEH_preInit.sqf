#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

if (hasInterface) then {
    // Save current time delay in case it changes (to adjust remaining respawn time)
    GVAR(oldTime) = GVAR(time);
    // Support variable in case respawn gets disabled, so when reenabled timer can continue
    GVAR(timeElapsed) = 0;
    // Equipment saved for respawn
    GVAR(savedEquipment) = [];
};

ADDON = true;
