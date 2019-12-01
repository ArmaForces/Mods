#include "script_component.hpp"

class RscText;
class RscTitle;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscControlsGroupNoScrollbars;
class RscStructuredText;

#define MODAL_W                 28
#define MODAL_WIDE_W            38
#define MODAL_MAIN_BTN_W        6.25
#define MODAL_CONTENT_BORDER    0.2

// Modal - standard
class GVAR(Modal) {
    idd = -1;
    enableSimulation = 0;

    onLoad = QUOTE(_this call FUNC(onModalOpen));
    onUnload = QUOTE(_this call FUNC(onModalClose));

    class ControlsBackground {
        class TitleBackground: RscText {
            colorBackground[] = COLOR_BCG;

            x = QUOTE(POS_X(7));
            y = QUOTE(POS_Y(1));
            w = QUOTE(POS_W(MODAL_W));
            h = QUOTE(POS_H(1));
        };
        class MainBackground: RscText {
            colorBackground[] = {0,0,0,0.7};

            x = QUOTE(POS_X(7));
            y = QUOTE(POS_Y(2.1));
            w = QUOTE(POS_W(MODAL_W));
            h = QUOTE(POS_H(20));
        };
    };

    class Controls {
        class TitleLeft: RscTitle {
            idc = IDC_MODAL_TITLE_L;
            style = ST_LEFT;

            text = "$STR_DISP_OPTIONS_GAME_OPTIONS";

            x = QUOTE(POS_X(7));
            y = QUOTE(POS_Y(1));
            w = QUOTE(POS_W(MODAL_W/2));
            h = QUOTE(POS_H(1));
        };
        class TitleRight: TitleLeft {
            idc = IDC_MODAL_TITLE_R;
            style = ST_RIGHT;
            // colorBackground[] = {0,0,0,0};

            text = "$STR_DISP_OPTIONS_GAME_OPTIONS";

            x = QUOTE(POS_X(7+MODAL_W/2));
            w = QUOTE(POS_W(MODAL_W/2));
        };

        // Content container
        class Content: RscControlsGroupNoScrollbars {
            idc = IDC_MODAL_GROUP_CONTENT;

            x = QUOTE(POS_X(7 + MODAL_CONTENT_BORDER));
            y = QUOTE(POS_Y(2.1 + MODAL_CONTENT_BORDER));
            w = QUOTE(POS_W(MODAL_W - MODAL_CONTENT_BORDER*2));
            h = QUOTE(POS_H(20 - MODAL_CONTENT_BORDER*2));

            class Controls {
                class Text: RscStructuredText {
                    idc = IDC_MODAL_CONTENT_TEXT;

                    // relative to ctrl group
                    x = 0;
                    y = 0;
                    // relative to display
                    w = QUOTE(POS_W(MODAL_W - MODAL_CONTENT_BORDER*2));
                    h = QUOTE(POS_H(20 - MODAL_CONTENT_BORDER*2));
                };
            };
        };

        class ButtonOK: RscButtonMenuOK {
            idc = IDC_OK;

            x = QUOTE(POS_X(7 + MODAL_W - MODAL_MAIN_BTN_W));
            y = QUOTE(POS_Y(22.2));
            w = QUOTE(POS_W(MODAL_MAIN_BTN_W));
            h = QUOTE(POS_H(1));
        };
        class ButtonCancel: RscButtonMenuCancel {
            idc = IDC_CANCEL;

            x = QUOTE(POS_X(7 + MODAL_W - MODAL_MAIN_BTN_W*2 - 0.2));
            y = QUOTE(POS_Y(22.2));
            w = QUOTE(POS_W(MODAL_MAIN_BTN_W));
            h = QUOTE(POS_H(1));
        };
    };
};

// Modal - wide
class GVAR(ModalWide): GVAR(Modal) {
    class ControlsBackground: ControlsBackground {
        class TitleBackground: TitleBackground {
            x = QUOTE(POS_X(1));
            w = QUOTE(POS_W(MODAL_WIDE_W));
        };
        class MainBackground: MainBackground {
            x = QUOTE(POS_X(1));
            w = QUOTE(POS_W(MODAL_WIDE_W));
        };
    };

    class Controls: Controls {
        class TitleLeft: TitleLeft {
            x = QUOTE(POS_X(1));
            w = QUOTE(POS_W(MODAL_WIDE_W/2));
        };
        class TitleRight: TitleRight {
            x = QUOTE(POS_X(1+MODAL_WIDE_W/2));
            w = QUOTE(POS_W(MODAL_WIDE_W/2));
        };

        class Content: Content {
            x = QUOTE(POS_X(1));
            w = QUOTE(POS_W(MODAL_WIDE_W - MODAL_CONTENT_BORDER*2));

            class Controls: Controls {
                class Text: Text {
                    // relative to display
                    w = QUOTE(POS_W(MODAL_WIDE_W - MODAL_CONTENT_BORDER*2));
                };
            };
        };

        class ButtonOK: ButtonOK {
            x = QUOTE(POS_X(1 + MODAL_WIDE_W - MODAL_MAIN_BTN_W));
        };
        class ButtonCancel: ButtonCancel {
            x = QUOTE(POS_X(1 + MODAL_WIDE_W - MODAL_MAIN_BTN_W*2 - 0.2));
        };
    };
};
