#define COMPONENT ace_anims
#include "\z\afm\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
#define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_ACE_ANIMS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ACE_ANIMS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ACE_ANIMS
#endif

#include "\z\afm\addons\main\script_macros.hpp"

// displayName = CSTRING(DOUBLES(Anim,NAME));
#define ANIMACTION(NAME,ICON,ANIM) \
    class NAME {\
        displayName = DOUBLES(Anim,NAME);\
        icon = ICON;\
        statement = QUOTE(ARR_2([_player, 'ANIM'] call FUNC(playAnim)));\
    }
