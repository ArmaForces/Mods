class RscControlsGroupNoScrollbars;
class RscStructuredText;
class RscButtonMenu;
class RscText;
class RscEdit;

#define SERVER_STATUS_H 5
#define SERVER_STATUS_W 20

#define SERVER_STATUS_TITLE_H 1

#define SERVER_STATUS_CONTENT_H (SERVER_STATUS_H - SERVER_STATUS_TITLE_H - SERVER_STATUS_BUTTONS_H)

#define SERVER_STATUS_BUTTONS_H 1
#define SERVER_STATUS_BUTTONS_Y (SERVER_STATUS_TITLE_H + SERVER_STATUS_CONTENT_H)

class RscStandardDisplay;
class RscDisplayClient: RscStandardDisplay {
    class Controls {
        class GVAR(serverStatus): RscControlsGroupNoScrollbars {
            onLoad = QUOTE(with uiNamespace do {call FUNC(serverStatusOnLoad)});

                x = QUOTE(safezoneX + POS_W(1));
                y = QUOTE(safeZoneY + 3.5 * POS_H(1));
                w = QUOTE(POS_W(SERVER_STATUS_W));
                h = QUOTE(POS_H(SERVER_STATUS_H));

            class Controls {
                class TitleBackground: RscText {
                    colorBackground[] = COLOR_BCG;

                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(SERVER_STATUS_W));
                    h = QUOTE(POS_H(SERVER_STATUS_TITLE_H));
                };
                class Title: RscStructuredText {
                    idc = IDC_SERVERSTATUS_TITLE;

                    colorText[] = {1,1,1,1};

                    size = QUOTE(POS_H(1));

                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(SERVER_STATUS_W));
                    h = QUOTE(POS_H(SERVER_STATUS_TITLE_H));
                };

                class DescriptionBackground: RscText {
                    colorBackground[] = COLOR_BCG_TRANS;

                    x = 0;
                    y = QUOTE(POS_H(SERVER_STATUS_TITLE_H));
                    w = QUOTE(POS_W(SERVER_STATUS_W));
                    h = QUOTE(POS_H(SERVER_STATUS_CONTENT_H));
                };
                class Description: RscStructuredText {
                    idc = IDC_SERVERSTATUS_DESCRIPTION;

                    colorText[] = {1,1,1,1};

                    size = QUOTE(POS_H(0.85));

                    x = 0;
                    y = QUOTE(POS_H(SERVER_STATUS_TITLE_H));
                    w = QUOTE(POS_W(SERVER_STATUS_W));
                    h = QUOTE(POS_H(SERVER_STATUS_CONTENT_H));
                };

                class ButtonsRow: RscControlsGroupNoScrollbars {
                    x = 0;
                    y = QUOTE(POS_H(SERVER_STATUS_BUTTONS_Y));
                    w = QUOTE(POS_W(SERVER_STATUS_W));
                    h = QUOTE(POS_H(SERVER_STATUS_BUTTONS_H));

                    class Controls {
                        class PasswordInput: RscEdit {
                            idc = IDC_SERVERSTATUS_PASSWORD;

                            x = 0;
                            y = 0;
                            w = QUOTE(POS_W(SERVER_STATUS_W/4 * 2));
                            h = QUOTE(POS_H(SERVER_STATUS_BUTTONS_H));
                        };
                        class LoginButton: RscButtonMenu {
                            idc = IDC_SERVERSTATUS_LOGIN;

                            x = QUOTE(POS_W(SERVER_STATUS_W/4 * 2));
                            y = 0;
                            w = QUOTE(POS_W(SERVER_STATUS_W/4 * 1));
                            h = QUOTE(POS_H(SERVER_STATUS_BUTTONS_H));
                        };
                        class MissionsButton: RscButtonMenu {
                            idc = IDC_SERVERSTATUS_MISSIONS;

                            x = QUOTE(POS_W(SERVER_STATUS_W/4 * 3));
                            y = 0;
                            w = QUOTE(POS_W(SERVER_STATUS_W/4 * 1));
                            h = QUOTE(POS_H(SERVER_STATUS_BUTTONS_H));
                        };
                    };
                };
            };
        };
    };
};
