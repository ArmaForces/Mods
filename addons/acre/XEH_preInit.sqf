#include "script_component.hpp"
ADDON = false;

if (!EGVAR(common,acre)) exitWith {};

#include "XEH_PREP.hpp"

#include "initSettings.sqf"

private _copyRootAction = [
    QGVAR(copyLeaderRadio),
    "Copy leader radio settings",
    ICON_RADIO_CALL,
    nil,
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

ADDON = true;
