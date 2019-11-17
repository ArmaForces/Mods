class RscFrame;
class RscText;
class RscButton;

class GVAR(teleportDialog) {
    idd = 11;
    movingEnable = 0;

    class controls {
        class RscFrame_1058: RscFrame {
            idc = 1800;
            x = "0.402031 * safezoneW + safezoneX";
            y = "0.357 * safezoneH + safezoneY";
            w = "0.195937 * safezoneW";
            h = "0.165 * safezoneH";
        };
        class TeleportText: RscText {
            idc = 1000;
            text = CSTRING(TeleportAsk);
            x = "0.412344 * safezoneW + safezoneX";
            y = "0.368 * safezoneH + safezoneY";
            w = "0.180469 * safezoneW";
            h = "0.055 * safezoneH";
        };
        class AgreeButton: RscButton {
            idc = 1600;
            text = CSTRING(TeleportAgree);
            x = "0.407187 * safezoneW + safezoneX";
            y = "0.445 * safezoneH + safezoneY";
            w = "0.0670312 * safezoneW";
            h = "0.066 * safezoneH";
            action = QUOTE(call FUNC(dialogConfirm); closeDialog 0);
        };
        class RejectButton: RscButton {
            idc = 1601;
            text = CSTRING(TeleportReject);
            x = "0.525781 * safezoneW + safezoneX";
            y = "0.445 * safezoneH + safezoneY";
            w = "0.0670312 * safezoneW";
            h = "0.066 * safezoneH";
            action = QUOTE(call FUNC(dialogReject); closeDialog 0);
        };
    };
};
