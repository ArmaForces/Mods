{
    for "_channelNumber" from 1 to 10 step 1 do {
        private _variableName = [_x, _channelNumber] call FUNC(getSideChannelNumberVariableName);
        private _settingName = format [LLSTRING(ChannelName), _channelNumber];
        private _settingDescription = format [LLSTRING(ChannelName_Description), _channelNumber];
        private _categoryName = format [LLSTRING(SideChannelNames), _x];
        [
            _variableName,
            "EDITBOX",
            [_settingName, _settingDescription],
            [LSTRING(DisplayName), _categoryName],
            _settingName,
            1,
            {},
            true
        ] call CBA_fnc_addSetting;
    };
} forEach [WEST, EAST, INDEPENDENT, CIVILIAN];
