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

_display displayaddeventhandler ["mouseMoving", {with uinamespace do {call FUNC(onLoad)}}];
_display displayaddeventhandler ["mouseHolding",{with uinamespace do {call FUNC(onLoad)}}];
_display displayaddeventhandler ["childDestroyed",{with uinamespace do {call FUNC(onUnload)}}];

_display call FUNC(addServerStatusPanel);

nil
