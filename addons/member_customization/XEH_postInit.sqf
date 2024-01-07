#include "script_component.hpp"

call {
    if (!(toLower worldName in ["chernarus", "chernarus_summer", "chernarus_winter"]) || !hasInterface) exitWith {};

    INFO("Spawning ""SK Bolec 17 kills graffiti and sign""");

    private _pub = nearestObjects [[6898, 2560, 0], ["Land_A_Pub_01"], 25] param [0, objNull];
    if (!alive _pub || {isObjectHidden _pub}) exitWith {};
    GVAR(bolec_17kills_graffiti) = createSimpleObject [QGVAR(graffiti_chernarus_bolec_17kills), [0,0,0], true];
    GVAR(bolec_17kills_graffiti) setPosASL [6899.62,2569.36,7.35698];
    GVAR(bolec_17kills_graffiti) setVectorDirAndUp [[0.040473,-0.999181,0], [0,0,1]];
    _pub addEventHandler ["Killed", {
        deleteVehicle (missionNamespace getVariable [QGVAR(bolec_17kills_graffiti), objNull]);
    }];

    private _sign = nearestObjects [[6898, 2569, 4], ["Land_SignB_Pub_CZ3"], 25] param [0, objNull];
    if (!alive _sign || {isObjectHidden _sign}) exitWith {};
    GVAR(bolec_17kills_banner) = createSimpleObject [QGVAR(banner_chernarus_bolec_17kills), [0,0,0], true];
    GVAR(bolec_17kills_banner) setPosWorld [6898,2569.32,10.394];
    GVAR(bolec_17kills_banner) setVectorDirAndUp [[0.0561846,-1.39887,-4.45146e-008], [-1.39887,-0.0561846,6.69994e-010]];
    GVAR(bolec_17kills_banner) setObjectScale 1.4;
    _sign addEventHandler ["Killed", {
        deleteVehicle (missionNamespace getVariable [QGVAR(bolec_17kills_banner), objNull]);
    }];
};
