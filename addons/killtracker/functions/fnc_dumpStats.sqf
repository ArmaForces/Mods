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

diag_log text "------ [START_KILLTRACKER_STATS] ------";
diag_log nil;

{
    diag_log text _x;
} forEach acex_killTracker_eventsArray;

diag_log nil;
diag_log text "------ [END_KILLTRACKER_STATS] ------";

nil

