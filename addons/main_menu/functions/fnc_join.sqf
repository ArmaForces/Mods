#include "script_component.hpp"
/*
 * Author: veteran29
 * Join ArmaForces server from main menu.
 * Based on article from KillZonekid
 *
 * Arguments:
 * 1: Spotlight tile control that was clicked <CONTROL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#define MULTI_SESSIONS_CTRL     (findDisplay IDD_MULTIPLAYER displayCtrl IDC_MULTI_SESSIONS)

params ["_button"];

// if no world is loaded missionNamespace will be empty
// copy logging function from uiNamespace
if (isNil "CBA_fnc_log") then {
    CBA_fnc_log = uiNamespace getVariable "CBA_fnc_log";
};

// Disable Enchanced Multiplayer Menu for compatiblity with this script
uiNamespace setVariable ["EMM_multiplayerMenu_enabled", false];

INFO("Auto joining to ArmaForces server");

GVAR(serverAddress) = "server.armaforces.com";
GVAR(serverPort) = "2302";
GVAR(joinTimeout) = diag_tickTime + 5;

// "Click" server browser from main menu
ctrlActivate ((ctrlParent _button) displayctrl IDC_MAIN_MULTIPLAYER);

onEachFrame {
    onEachFrame {
        // Direct connect button
        ctrlActivate (findDisplay IDD_MULTIPLAYER displayCtrl IDC_MULTI_TAB_DIRECT_CONNECT);

        onEachFrame {
            // Fill server data
            private _ctrlServerAddress = findDisplay IDD_IP_ADDRESS displayCtrl 2300;
            _ctrlServerAddress controlsGroupCtrl IDC_IP_ADDRESS ctrlSetText GVAR(serverAddress);
            _ctrlServerAddress controlsGroupCtrl IDC_IP_PORT ctrlSetText GVAR(serverPort);
            ctrlActivate (_ctrlServerAddress controlsGroupCtrl IDC_OK);

            onEachFrame {
                (MULTI_SESSIONS_CTRL lbData 0) call {
                    LOG_2("Joining - time: %1 - timeout: %2",diag_tickTime,GVAR(joinTimeout));

                    if (diag_tickTime > GVAR(joinTimeout)) then {
                        ERROR("Join timeout - no server");
                        onEachFrame {};
                    };

                    if (_this != "") then {
                        MULTI_SESSIONS_CTRL lbSetCurSel 0;

                        onEachFrame {
                            INFO("Activating join button");
                            ctrlActivate (findDisplay IDD_MULTIPLAYER displayCtrl IDC_MULTI_JOIN);

                            onEachFrame {
                                if (diag_tickTime > GVAR(joinTimeout)) then {
                                    WARNING("Join timeout");
                                    onEachFrame {};
                                };

                                if (!isNull findDisplay IDD_PASSWORD) then {
                                    INFO("Password prompt");
                                    private _ctrlPassword = findDisplay IDD_PASSWORD displayCtrl IDC_PASSWORD;
                                    private _savedPassword = ctrlText  _ctrlPassword;

                                    if(count _savedPassword > 0) then {
                                        _ctrlPassword ctrlSetText _savedPassword;
                                        ctrlActivate (findDisplay IDD_PASSWORD displayCtrl IDC_OK);
                                        INFO("Saved password found, joining");
                                        onEachFrame {};
                                    } else {
                                        INFO("No saved password, user interaction required");
                                        onEachFrame {};
                                    };
                                };

                                if (getClientStateNumber >= 3) then {
                                    INFO("Connection successful");
                                    onEachFrame {};
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};

nil
