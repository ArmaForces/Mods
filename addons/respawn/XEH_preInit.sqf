#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

if (hasInterface) then {
    // Save current time delay in case it changes (to adjust remaining respawn time)
    GVAR(oldTime) = GVAR(time);
    // Support variable in case respawn gets disabled, so when reenabled timer can continue
    GVAR(timeElapsed) = 0;
    // Equipment saved for respawn
    GVAR(savedEquipment) = [];
};

ADDON = true;
