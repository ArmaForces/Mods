PREP(canSpectate);
PREP(disable);
PREP(enable);
PREP(reloadLocal);
PREP(restart);
PREP(start);
PREP(stop);
PREP(toggle);

PREP(onDisplayLoad);
PREP(addPlayerStatePanel);

BIS_fnc_EGSpectator = compile preProcessFileLineNumbers 'PATHTO_SYS(PREFIX,COMPONENT_F,DOUBLES(fnc,EGSpectator))';
