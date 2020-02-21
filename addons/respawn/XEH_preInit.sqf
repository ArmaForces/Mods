#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

GVAR(time) = getNumber (configFile >> "CfgRespawnTemplates" >> QGVAR(default) >> "respawnDelay");
GVAR(timeElapsed) = 0;
GVAR(savedEquipment) = [];

ADDON = true;
