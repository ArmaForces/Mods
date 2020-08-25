#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function teleports player back to his position before he disconnected and restores his loadout.
 *
 * Arguments:
 * 0: Player loadout <ARRAY>
 * 1: Player vehicle <OBJECT>
 * 2: Destination <POSITION>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, getPos leader group player, getUnitLoadout player] call afm_back_to_game_fnc_teleportPlayer
 *
 * Public: No
 */

params ["", "", "_vehicle", "_pos"];

private _leader = leader group player;

switch (true) do {
    // Teleportation to leader is enabled. Teleport to leader or leader's vehicle.
    case (GVAR(teleportToLeader) && {_leader != player}): {
        private _leaderVehicle = vehicle _leader;
        if (GVAR(teleportToVehicle) && {_leaderVehicle != _leader}) then {
            private _success = player moveInAny _leaderVehicle;
            if !(_success) then {
                // No point in teleporting to leader as player probably would be instantly killed by vehicle
                player setPos _pos;
            };
        } else {
            player setPos getPos _leader;
        };
    };
    // Teleporation to vehicle is enabled.
    case (GVAR(teleportToVehicle) && {_vehicle != player}): {
        private _success = player moveInAny _vehicle;
        if !(_success) then {
            player setPos _pos;
        };
    };
    default {
        player setPos _pos;
    };
};

INFO("Teleported player.");

nil
