#include "script_component.hpp"

if (hasInterface) then {
    addMissionEventHandler ["HandleChatMessage", {
        call FUNC(handleChatMessage);
    }];
};
