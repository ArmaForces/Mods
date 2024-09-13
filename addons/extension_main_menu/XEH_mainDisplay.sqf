#define DEBUG_SYNCHRONOUS
#include "script_component.hpp"
/*
 * Author: veteran29
 * Handle initialization of main menu display.
 *
 * Arguments:
 * 0: Main display <DISPLAY>
 *
 * Return Value:
 * None
 */

params ["_display"];
TRACE_1("Main display",_display);

_display displayAddEventHandler ["MouseMoving", {with uiNamespace do {call FUNC(onLoad)}}];
_display displayAddEventHandler ["MouseHolding",{with uiNamespace do {call FUNC(onLoad)}}];
_display displayAddEventHandler ["ChildDestroyed",{with uiNamespace do {call FUNC(onUnload)}}];

_display call FUNC(addServerStatusPanel);

nil
