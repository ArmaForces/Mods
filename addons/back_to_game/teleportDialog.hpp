class RscFrame;
class RscText;
class RscButton;

class GVAR(teleportDialog) {
    idd = 11;
    movingEnable = 0;

    class controls {
        class RscFrame_1058: RscFrame {
            idc = 1800;
            x = "0.402031 * safeZoneW + safeZoneX";
            y = "0.357 * safeZoneH + safeZoneY";
            w = "0.195937 * safeZoneW";
            h = "0.165 * safeZoneH";
        };
        class TeleportText: RscText {
            idc = 1000;
            text = CSTRING(TeleportAsk);
            x = "0.412344 * safeZoneW + safeZoneX";
            y = "0.368 * safeZoneH + safeZoneY";
            w = "0.180469 * safeZoneW";
            h = "0.055 * safeZoneH";
        };
        class AgreeButton: RscButton {
            idc = 1600;
            text = CSTRING(TeleportAgree);
            x = "0.407187 * safeZoneW + safeZoneX";
            y = "0.445 * safeZoneH + safeZoneY";
            w = "0.0670312 * safeZoneW";
            h = "0.066 * safeZoneH";
            action = QUOTE(call FUNC(dialogConfirm); closeDialog 0);
        };
        class RejectButton: RscButton {
            idc = 1601;
            text = CSTRING(TeleportReject);
            x = "0.525781 * safeZoneW + safeZoneX";
            y = "0.445 * safeZoneH + safeZoneY";
            w = "0.0670312 * safeZoneW";
            h = "0.066 * safeZoneH";
            action = QUOTE(call FUNC(dialogReject); closeDialog 0);
        };
    };
};
