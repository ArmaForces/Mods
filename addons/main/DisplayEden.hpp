class CtrlMenuStrip;
class Display3DEN {
    class Controls {
        class MenuStrip: CtrlMenuStrip {
            class Items {
                items[] += {QUOTE(PREFIX)};
                class PREFIX {
                    text = CSTRING(Toolbar);
                    items[] += {
                        QGVAR(Wiki)
                    };
                };
                class GVAR(Wiki) {
                    text = CSTRING(ToolbarWiki);
                    picture = "\a3\3DEN\Data\Controls\ctrlMenu\link_ca.paa";
                    weblink = "https://wiki.armaforces.com/";
                    opensNewWindow = 1;
                };
            };
        };
    };
};
