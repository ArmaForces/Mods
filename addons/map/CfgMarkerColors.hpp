class CfgMarkerColors {
    class Default;
    class ColorRed: Default {
        name = CSTRING(ColorRed);
    };
    class ColorBlue: Default {
        name = CSTRING(ColorBlue);
    };
    class ColorGreen: Default {
        name = CSTRING(ColorGreen);
    };
    class ColorOrange: Default {
        name = CSTRING(ColorOrange);
        scope = 2;
    };
    class ColorPink: Default {
        name = CSTRING(ColorPink);
        scope = 2;
        color[] = {1, 0, 1, 1};
    };
};
