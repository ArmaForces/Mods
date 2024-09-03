#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afm_common",
            "a3_functions_f_exp_a"
        };
        author = "ArmaForces";
        VERSION_CONFIG;
    };
};


#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgScriptPaths.hpp"
#include "RscDisplayEGSpectator.hpp"
