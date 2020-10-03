#include "script_component.hpp"
ADDON = false;

if (!EGVAR(common,acre)) exitWith {};

#include "XEH_PREP.hpp"

#include "initSettings.sqf"

if (EGVAR(common,aceArsenal) && {GVAR(addArsenalCategory)}) then {
    // Can't use WUAE as it won't run in 3DEN
    [] spawn {
        private _timeout = diag_tickTime + 5;
        waitUntil {
            !isNil "acre_api_fnc_getAllRadios" || {diag_tickTime > _timeout};
        };

        GVAR(arsenalButton) = [
            ([] call acre_api_fnc_getAllRadios) select 0,
            LLSTRING(Radios),
            "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa"
        ] call ACEFUNC(arsenal,addRightPanelButton);
    };
};

ADDON = true;
