class RscControlsGroupNoScrollbars;
class RscStructuredText;
class RscButtonMenu;
class RscText;
class RscEdit;

#define SERVER_STATUS_H 5
#define SERVER_STATUS_W 20

#define SERVER_STATUS_TITLE_H 1

#define SERVER_STATUS_CONTENT_H (SERVER_STATUS_H - SERVER_STATUS_TITLE_H - SERVER_STATUS_BUTTONS_H)

#define SERVER_STATUS_BUTTONS_H 1
#define SERVER_STATUS_BUTTONS_Y (SERVER_STATUS_TITLE_H + SERVER_STATUS_CONTENT_H)

class RscStandardDisplay;
#include "RscDisplayMain.hpp"
#include "RscDisplayClient.hpp"
