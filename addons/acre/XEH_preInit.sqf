#include "script_component.hpp"
ADDON = false;

if (!EGVAR(common,acre)) exitWith {};

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

// Add arsenal category
if (EGVAR(common,aceArsenal) && {GVAR(addArsenalCategory)}) then {
    // Can't use WUAE as it won't run in 3DEN
    [] spawn {
        private _timeout = diag_tickTime + 5;
        waitUntil {
            !isNil "acre_api_fnc_getAllRadios" || {diag_tickTime > _timeout};
        };

        GVAR(arsenalButton) = [
            [] call FUNC(getAllRadios),
            LLSTRING(ArsenalCategory),
            "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\radio_ca.paa"
        ] call ACEFUNC(arsenal,addRightPanelButton);
    };
};

// Add leader radio copy interaction
if (EGVAR(common,aceInteractMenu)) then {
    private _copyRootAction = [
        QGVAR(copyLeaderRadio),
        LLSTRING(CopyLeaderRadio),
        ICON_RADIO_CALL,
        {},
        {
            private _leader = leader _player;
            _player != _leader
            && {
                _player distance _leader < 50
                && {[_player, _target, []] call ace_common_fnc_canInteractWith}
            }
        },
        {_this call FUNC(copyLeaderRadioChildrenActions)}
    ] call ace_interact_menu_fnc_createAction;
    ["CAManBase", 1, ["ACE_SelfActions", "ACE_TeamManagement"], _copyRootAction, true] call ace_interact_menu_fnc_addActionToClass;
};

ADDON = true;
