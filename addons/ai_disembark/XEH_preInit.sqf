#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

["CAManBase", "GetOutMan", {
    _this call FUNC(onDisembark);
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
