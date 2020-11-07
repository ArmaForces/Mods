#include "script_component.hpp"

class RscPicture;
class RscIGUIText;
class RscControlsGroupNoScrollbars;
class RscListBox;

// Based on RscCustomInfoCrew
class GVAR(RscBasicComponent) {
    idd = -1;

    onLoad = 'uiNamespace setVariable [QGVAR(RscBasicComponent), _this select 0]';
    onUnload = "";

    class controlsBackground {
        class Background: RscPicture {
            idc = COMPONENT_BG_IDC;
            text = "A3\Ui_f\data\IGUI\RscCustomInfo\background_ca.paa";
            x = '0 * GUI_GRID_W';
            y = '1 * GUI_GRID_H';
            w = 'IGUI_GRID_CUSTOMINFO_WAbs';
            h = 'IGUI_GRID_CUSTOMINFO_HAbs - 1 * GUI_GRID_H';

            colorText[] = IGUI_BCG_COLOR;
        };
        class BackgroundGroup: RscControlsGroupNoScrollbars {
            idc = COMPONENT_BGGRP_IDC;

            x = '0.125 * GUI_GRID_W';
            y = '1.125 * GUI_GRID_H';
            w = 'IGUI_GRID_CUSTOMINFO_INNER_WAbs';
            h = 'IGUI_GRID_CUSTOMINFO_INNER_HAbs';

            class controls {};
        };
    };

    class controls {
        class Title: RscIGUIText
        {
            idc = COMPONENT_TEXT_IDC;
            text = "BasicComponent";
            x = 0;
            y = 0;
            h = '1 * GUI_GRID_H';
            w = 'IGUI_GRID_CUSTOMINFO_WAbs';

            sizeEx = '0.8 * GUI_GRID_H';
            colorBackground[] = IGUI_BCG_COLOR;
        };
        class Content: RscControlsGroupNoScrollbars {
            idc = COMPONENT_CONTENT_IDC;

            x = '0.125 * GUI_GRID_W';
            y = '1.125 * GUI_GRID_H';
            w = 'IGUI_GRID_CUSTOMINFO_INNER_WAbs';
            h = 'IGUI_GRID_CUSTOMINFO_INNER_HAbs';

            class controls {
                /*class ItemsList: RscListBox {
                    idc = 101;

                    x = 0;
                    y = 0;
                    w = 'IGUI_GRID_CUSTOMINFO_INNER_WAbs';
                    h = 'IGUI_GRID_CUSTOMINFO_INNER_HAbs';

                    sizeEx = '0.8 * GUI_GRID_H';
                    colorBackground[] = {0, 0, 0, 0};

                    text = "";
                    onLoad = "(_this select 0) lbAdd 'Test item 1'";
                };*/
            };
        };
    };
};

