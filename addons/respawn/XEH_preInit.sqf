#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

GVAR(respawnTime) = getNumber (configFile >> "CfgRespawnTemplates" >> GVAR(default) >> "respawnDelay");
GVAR(respawnTimeElapsed) = 0;
GVAR(savedEquipment) = [];

ADDON = true;
