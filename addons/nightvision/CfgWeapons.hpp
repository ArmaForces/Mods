#define BROKEN_GOGGLES(ORIGINAL_NVG) class ORIGINAL_NVG; \
class GVAR(DOUBLES(ORIGINAL_NVG,Broken)) : ORIGINAL_NVG { \
        scope = 1; \
        visionMode[] = {"Normal"} \
}

class CfgWeapons {
    BROKEN_GOGGLES(ACE_NVG_Gen1);
    BROKEN_GOGGLES(ACE_NVG_Gen2);
    BROKEN_GOGGLES(ACE_NVG_Gen4);
    BROKEN_GOGGLES(ACE_NVG_Wide);
    BROKEN_GOGGLES(NVGoggles);
    BROKEN_GOGGLES(NVGoggles_INDEP);
    BROKEN_GOGGLES(NVGoggles_OPFOR);
    BROKEN_GOGGLES(NVGoggles_tna_F);
    BROKEN_GOGGLES(NVGogglesB_blk_F);
    BROKEN_GOGGLES(NVGogglesB_gry_F);
    BROKEN_GOGGLES(O_NVGoggles_ghex_F);
    BROKEN_GOGGLES(O_NVGoggles_grn_F);
    BROKEN_GOGGLES(O_NVGoggles_hex_F);
    BROKEN_GOGGLES(O_NVGoggles_urb_F);
};
