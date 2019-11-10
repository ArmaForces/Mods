#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_diagnostic"
        };
        author = "ArmaForces";
        VERSION_CONFIG;
    };
};

// Enable CBA target debugging
EnableTargetDebug = 1;

#include "CfgEventHandlers.hpp"
