#include "script_component.hpp"

class RscText;
class RscTitle;
class RscButtonMenuOK;
class RscButtonMenuCancel;

#define MODAL_W             28
#define MODAL_WIDE_W        38
#define MODAL_MAIN_BTN_W    6.25

class GVAR(Modal) {
    idd = -1;
    enableSimulation = 0;

    class ControlsBackground {
        class TitleBackground: RscText {
            colorBackground[] = COLOR_BCG;

            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(1));
            w = QUOTE(POS_W(MODAL_W));
            h = QUOTE(POS_H(1));
        };
        class MainBackground: RscText {
            colorBackground[] = {0,0,0,0.7};

            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(2.1));
            w = QUOTE(POS_W(MODAL_W));
            h = QUOTE(POS_H(20));
        };
    };

    class Controls {
        class TitleLeft: RscTitle {
            idc = 1000;
            style = ST_LEFT;

            text = "$STR_DISP_OPTIONS_GAME_OPTIONS";

            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(1));
            w = QUOTE(POS_W(MODAL_W/2));
            h = QUOTE(POS_H(1));
        };
        class TitleRight: TitleLeft {
            idc = 1001;
            style = ST_RIGHT;
            // colorBackground[] = {0,0,0,0};

            text = "$STR_DISP_OPTIONS_GAME_OPTIONS";

            x = QUOTE(POS_X(1+MODAL_W/2));
            w = QUOTE(POS_W(MODAL_W/2));
        };

        class ButtonOK: RscButtonMenuOK {
            idc = 1;

            x = QUOTE(POS_X(1 + MODAL_W - MODAL_MAIN_BTN_W));
            y = QUOTE(POS_Y(22.2));
            w = QUOTE(POS_W(MODAL_MAIN_BTN_W));
            h = QUOTE(POS_H(1));
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = 2;

            x = QUOTE(POS_X(1 + MODAL_W - MODAL_MAIN_BTN_W*2 - 0.2));
            y = QUOTE(POS_Y(22.2));
            w = QUOTE(POS_W(MODAL_MAIN_BTN_W));
            h = QUOTE(POS_H(1));
        };
    };
};

class GVAR(ModalWide): GVAR(Modal) {
    class ControlsBackground: ControlsBackground {
        class TitleBackground: TitleBackground {
            w = QUOTE(POS_W(MODAL_WIDE_W));
        };
        class MainBackground: MainBackground {
            w = QUOTE(POS_W(MODAL_WIDE_W));
        };
    };

    class Controls: Controls {
        class TitleLeft: TitleLeft {
            w = QUOTE(POS_W(MODAL_WIDE_W/2));
        };
        class TitleRight: TitleRight {
            x = QUOTE(POS_X(1+MODAL_WIDE_W/2));
            w = QUOTE(POS_W(MODAL_WIDE_W/2));
        };

        class ButtonOK: ButtonOK {
            x = QUOTE(POS_X(1 + MODAL_WIDE_W - MODAL_MAIN_BTN_W));
        };
        class ButtonCancel: ButtonCancel {
            x = QUOTE(POS_X(1 + MODAL_WIDE_W - MODAL_MAIN_BTN_W*2 - 0.2));
        };
    };
};
