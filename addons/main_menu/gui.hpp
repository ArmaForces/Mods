class RscControlsGroupNoScrollbars;
class RscStructuredText;

class RscStandardDisplay;
class RscDisplayClient: RscStandardDisplay {
    class Controls {
        class GVAR(serverStatus): RscControlsGroupNoScrollbars {
            onLoad = QUOTE(with uiNamespace do {call FUNC(serverStatusOnLoad)});

                x = QUOTE(safezoneX + POS_W(1));
                y = QUOTE(safeZoneY + 4 * POS_H(1));
                w = POS_W(20);
                h = POS_H(4);

            class Controls {
                class TitleBackground: RscText {
                    colorBackground[] = COLOR_BCG;

                    x = 0;
                    y = 0;
                    w = POS_W(20);
                    h = POS_H(1);
                };
                class Title: RscStructuredText {
                    idc = 1000;

                    colorText[] = {1,1,1,1};

                    size = QUOTE(POS_H(1));

                    x = 0;
                    y = 0;
                    w = QUOTE(POS_W(20));
                    h = QUOTE(POS_H(1));
                };
            };
        };
    };
};
