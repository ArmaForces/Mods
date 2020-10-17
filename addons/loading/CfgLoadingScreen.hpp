#define LOADING_SCREEN_CLASS(className,authorName) \
    class className { \
        author = QUOTE(authorName); \
        path = QPATHTOF(ui\loading\##className##_co.paa); \
    }

class GVAR(CfgLoadingScreen) {
    class Backgrounds {
        LOADING_SCREEN_CLASS(cup_0,ARR_2(Norek, WINDOWS_95_SE));
        LOADING_SCREEN_CLASS(gm_0,Mikkeboss);
        LOADING_SCREEN_CLASS(ifa_0,Mikkeboss);
        LOADING_SCREEN_CLASS(ifa_1,Krystol);
        LOADING_SCREEN_CLASS(ifa_2,veteran29);
        LOADING_SCREEN_CLASS(rhs_0,Monk[e]y);
        LOADING_SCREEN_CLASS(rhs_1,ARR_2(Mikkeboss, JurijPietrowicz));
        LOADING_SCREEN_CLASS(rhs_2,Mikkeboss);
        LOADING_SCREEN_CLASS(rhs_3,Monk[e]y);
        LOADING_SCREEN_CLASS(rhs_4,ARR_2(Norek, Nomus));
        LOADING_SCREEN_CLASS(rhs_5,Bolec);
        LOADING_SCREEN_CLASS(rhs_6,Bolec);
        LOADING_SCREEN_CLASS(vanilla_0,Monk[e]y);
        LOADING_SCREEN_CLASS(other_0,Monk[e]y);
        LOADING_SCREEN_CLASS(other_1,Monk[e]y);
        LOADING_SCREEN_CLASS(unsung_0,WINDOWS_95_SE);
        LOADING_SCREEN_CLASS(unsung_1,3Mydlo3);
        LOADING_SCREEN_CLASS(postapo_0,Monk[e]y);
    };
};
