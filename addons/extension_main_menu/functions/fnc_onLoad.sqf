#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle initialization of main display/main display going to foreground.
 *
 * Arguments:
 * 0: Main display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (!isNull (uiNamespace getVariable [QGVAR(loop), scriptNull])) exitWith {};

params ["_display"];
TRACE_1("Main menu refresh",_display);

GVAR(extEh) = addMissionEventHandler ["ExtensionCallback", {
    params ["_name", "_function", "_data"];

    // fallback for -skipIntro param when XEH_preInit does not run and 'afm_extension' is not initialized.
    if (_name == EXT_LOG && !(missionNamespace getVariable ["afm_extension", false])) exitWith {
        LOG_SYS(_function,_data);
    };
    if (_name != EXT || _function != "get_server_status") exitWith {};

    // when world is not loaded mission namespace will be empty as preInit does not run.
    with uiNamespace do {
        parseSimpleArray _data call FUNC(updateServerStatus);
    };
}];

GVAR(loop) = [] spawn {
    uiSleep 0.5;
    while {true} do {
        EXT callExtension "get_server_status";
        uiSleep 60;
    };
};
