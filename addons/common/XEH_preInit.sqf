#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(aceSafemode) = IS_MOD_LOADED(ace_safemode);
GVAR(aceFastroping) = IS_MOD_LOADED(ace_fastroping);
GVAR(aceFatigue) = IS_MOD_LOADED(ace_advanced_fatigue);
GVAR(aceMedical) = IS_MOD_LOADED(ace_medical_engine);

if (isServer) then {
    GVAR(clientId) = "2";

    // publish Direct Play clientId to clients
    addMissionEventHandler ["PlayerConnected", {
        params ["", "", "", "", "_ownerId", "_clientIdStr"];

        // CBA events do not support client Id
        missionNamespace setVariable [QGVAR(clientId), _clientIdStr, _ownerId];
    }];
};

if (hasInterface) then {
    GVAR(playerMarkerIdx) = 0;
    GVAR(clientId) = "";
};

ADDON = true;
