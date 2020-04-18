#include "script_component.hpp"
/*
 * Author: veteran29
 * Checks if tank weapon shot can heat up the vehicle
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Weapon <STRING>
 * 7: Gunner <OBJECT>
 *
 * Return Value:
 * 0: Can vehicle heat up <BOOL>
 *
 * Public: No
 */
params ["_vehicle", "_weapon", "", "", "", "", "", "_gunner"];

local _vehicle && {(CBA_missionTime > _vehicle getVariable [QGVAR(heatTime), 0])
    && {(_weapon isKindOf ["CannonCore", configFile >> "CfgWeapons"])
        && {!isPlayer _gunner}
    }
}
