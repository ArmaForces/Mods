#include "script_component.hpp"
/*
 * Author: veteran29
 * Dumps ACEX Killtracker stats to RPT
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
 */

if (isNil "acex_killTracker_eventsArray") exitWith {
    WARNING("ACEX Killtracker not detected, can't show stats");
};

if (GVAR(statsDumped)) exitWith {};
GVAR(statsDumped) = true;

diag_log text "------ [START_KILLTRACKER_STATS] ------";

{
    diag_log text _x;
} forEach acex_killTracker_eventsArray;

diag_log text format ["Total kills: %1", count acex_killTracker_eventsArray];
diag_log text "------ [END_KILLTRACKER_STATS] ------";

nil
