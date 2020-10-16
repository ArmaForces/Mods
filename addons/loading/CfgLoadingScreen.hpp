#define LOADING_SCREEN_CLASS(className,authorName) \
    class className { \
        author = QUOTE(authorName); \
        path = QPATHTOF(ui\loading\##className##_co.paa); \
    }

class GVAR(CfgLoadingScreen) {
    class Backgrounds {
        LOADING_SCREEN_CLASS(gm_0,Mikeboss);
        LOADING_SCREEN_CLASS(ifa_0,Lesskovik);
        LOADING_SCREEN_CLASS(ifa_1,<unknown>);
        LOADING_SCREEN_CLASS(ifa_2,veteran29);
        LOADING_SCREEN_CLASS(rhs_0,<unknown>);
        LOADING_SCREEN_CLASS(rhs_1,ARR_2(Mikeboss, JurijPietrowicz));
        LOADING_SCREEN_CLASS(rhs_2,<unknown>);
        LOADING_SCREEN_CLASS(rhs_3,<unknown>);
        LOADING_SCREEN_CLASS(rhs_4,ARR_2(Norek, Nomus));
        LOADING_SCREEN_CLASS(rhs_5,Bolec);
        LOADING_SCREEN_CLASS(rhs_6,Bolec);
        LOADING_SCREEN_CLASS(vanilla_0,PanAnonim);
        LOADING_SCREEN_CLASS(other_0,Monk[e]y);
        LOADING_SCREEN_CLASS(other_1,Monk[e]y);
        LOADING_SCREEN_CLASS(unsung_0,<unknown>);
        LOADING_SCREEN_CLASS(unsung_1,3Mydlo3);
        LOADING_SCREEN_CLASS(postapo_0,Monk[e]y);
    };
};
