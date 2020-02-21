#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(respawnTime) = getNumber (configFile >> "CfgRespawnTemplates" >> GVAR(default) >> "respawnDelay");
GVAR(savedEquipment) = [];

ADDON = true;
