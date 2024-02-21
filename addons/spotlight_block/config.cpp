#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "A3_Ui_F" // minimal required addons so this component loads as early as possible
        };
        author = "ArmaForces";
        authors[] = {"veteran29"};
        VERSION_CONFIG;
    };
};

#define HIDE_CONTROL \
    x = 0; \
    y = 0; \
    w = 0; \
    h = 0

class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class BackgroundSpotlightRight;
        class GVAR(BackgroundSpotlightNoDelete): BackgroundSpotlightRight {
            HIDE_CONTROL;
        };

        class Spotlight1;
        class GVAR(Spotlight1NoDelete): Spotlight1 {
            HIDE_CONTROL;
        };
        class Spotlight2;
        class GVAR(Spotlight2NoDelete): Spotlight2 {
            HIDE_CONTROL;
        };
        class Spotlight3;
        class GVAR(Spotlight3NoDelete): Spotlight3 {
            HIDE_CONTROL;
        };
    };
};
