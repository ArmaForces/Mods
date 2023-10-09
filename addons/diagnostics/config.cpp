#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "afm_common"
        };
        author = "ArmaForces";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

// TODO: Move this somewhere appropriate
class GVAR(fpsListDialog) {
    idd = -1;
    movingEnable = 0;
    onLoad = QUOTE(_this call FUNC(fpsOpen));
};

class GVAR(dlcListDialog) {
    idd = -1;
    movingEnable = 0;
    onLoad = QUOTE(_this call FUNC(dlcOpen));
};
