class RscText;
class RscPicture;
class RscStandardDisplay;
class RscControlsGroup;
class RscPictureKeepAspect;
#define DISPLAY_LOADING_ADD_BG(displayClass) class displayClass: RscStandardDisplay { \
    class controls { \
        class LoadingStart: RscControlsGroup { \
            class controls { \
                class GVAR(background): RscPictureKeepAspect { \
                    idc = IDC_LOADINGSTART_CUSTOM_BG; \
                    text = QPATHTOF(ui\loading\0_co.paa); \
                    colorBackground[] = {0,0,0,0}; \
                    x = 0; \
                    y = 0; \
                    w = "safezoneW"; \
                    h = "safezoneH"; \
                }; \
                class GVAR(lines): RscPicture { \
                    text = "\A3\Ui_f\data\IGUI\RscTitles\SplashArma3\arma3_splashNoise_ca.paa"; \
                    x = 0; \
                    y = 0; \
                    w = "safezoneW"; \
                    h = "safezoneH"; \
                }; \
                class Logo; \
                class GVAR(logo): Logo { \
                    idc = -1; \
                    y = "0 * safezoneH"; \
                }; \
            }; \
        }; \
    }; \
}

DISPLAY_LOADING_ADD_BG(RscDisplayStart);
DISPLAY_LOADING_ADD_BG(RscDisplayLoadMission);
DISPLAY_LOADING_ADD_BG(RscDisplayNotFreeze);
