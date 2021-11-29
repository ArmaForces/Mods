#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call afm_main_fnc_example
 *
 * Public: No
 */

if (!isNull (uiNamespace getVariable [QGVAR(loop), scriptNull])) exitWith {};

params ["_display"];
INFO_1("Main menu refresh",_display);

GVAR(extEh) = addMissionEventHandler ["ExtensionCallback", {
    params ["_name", "_function", "_data"];

    // fallback for -skipIntro param when XEH_preInit does not run and 'afm_extension' is not initialized.
    if (_name == EXT_LOG && !(missionNamespace getVariable ["afm_extension", false])) exitWith {
        LOG_SYS(_function,_data);
    };
    if (_name != EXT || _function != "get_server_status") exitWith {};

    diag_log text format ["from extension - %1", _data];
}];

GVAR(loop) = [] spawn {
    uiSleep 0.5;
    while {true} do {
        EXT callExtension "get_server_status";
        uiSleep 60;
    };
};
