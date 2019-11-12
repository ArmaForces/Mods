#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.sqf"

GVAR(running) = false;
GVAR(markers) = [];
GVAR(trackedVehicles) = [];

ADDON = true;
