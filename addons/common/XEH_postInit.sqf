#include "script_component.hpp"

if (isServer) then {
    GVAR(admins) = allPlayers apply {owner _x} select {admin _x > 0};
    if (hasInterface) then {GVAR(admins) pushBackUnique 2}; // "admin" command does not work on dedicated server
    publicVariable QGVAR(admins);

    addMissionEventHandler ["OnUserAdminStateChanged", {
        params ["_networkId", "_loggedIn"];

        private _userInfo = getUserInfo _networkId;
        if (_userInfo isEqualTo []) exitWith {};

        private _ownerId = _userInfo select 1;
        if (_loggedIn) then {
            GVAR(admins) pushBackUnique _ownerId;
        } else {
            GVAR(admins) deleteAt (GVAR(admins) find _ownerId);
        };

        publicVariable QGVAR(admins);
    }];
};
