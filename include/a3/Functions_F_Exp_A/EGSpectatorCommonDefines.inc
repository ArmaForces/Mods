/**
 * Includes
 */
#include "\A3\ui_f\hpp\defineResincl.inc"
#include "\A3\ui_f\hpp\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"
#include "\A3\ui_f_exp_a\UI\defineResinclDesign.inc"

/**
 * Development
 */
#define LOG_ENABLED						true

/**
 * Functions
 */
#define SPEC							{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectator", {}]) }
#define SPEC_DRAW3D						{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorDraw3D", {}]) }
#define SPEC_DRAW2D						{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorDraw2D", {}]) }
#define SPEC_GET_UNITS_TO_DRAW			{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorGetUnitsToDraw", {}]) }
#define CAM								{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCamera", {}]) }
#define CAM_TICK						{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCameraTick", {}]) }
#define CAM_SET_TARGET					{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCameraSetTarget", {}]) }
#define CAM_RESET_TARGET				{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCameraResetTarget", {}]) }
#define CAM_PREPARE_TARGET				{ _this call (missionNamespace getVariable ["BIS_fnc_EGSpectatorCameraPrepareTarget", {}]) }
#define OBJECTIVE_VIZUALIZER			{ _this call (missionNamespace getVariable ["BIS_fnc_EGObjectiveVisualizer", {}]); }
#define OBJECTIVE_VIZUALIZER_DRAW		{ _this call (missionNamespace getVariable ["BIS_fnc_EGObjectiveVisualizerDraw", {}]); }
#define DISPLAY							{ _this call (uiNamespace getVariable ["RscDisplayEGSpectator_script", {}]) }
#define WIDGET 							{ _this call (uiNamespace getVariable ["RscEGProgress_script", {}]); }

/**
 * Spectator
 */
#define SPECTATOR_CLASS					"VirtualSpectator_F"
#define VAR_INITIALIZED					"BIS_EGSpectator_initialized"
#define VAR_THREAD						"BIS_EGSpectator_thread"
#define VAR_DRAW3D						"BIS_EGSpectator_draw3D"
#define VAR_CUSTOM_ICONS				"BIS_EGSpectator_customIcons"
#define VAR_LOCATIONS					"BIS_EGSpectator_locations"
#define VAR_ALLOW_AI_SWITCH				"BIS_EGSpectator_allowAiSwitch"
#define VAR_ALLOW_FREE_CAMERA			"BIS_EGSpectator_allowFreeCamera"
#define VAR_ALLOW_3PP_CAMERA			"BIS_EGSpectator_allow3PPCamera"
#define VAR_SHOW_FOCUS_INFO				"BIS_EGSpectator_showFocusInfo"
#define VAR_SHOW_CAMERA_BUTTONS			"BIS_EGSpectator_showCameraButtons"
#define VAR_SHOW_CONTROLS_HELPER		"BIS_EGSpectator_showControlsHelper"
#define VAR_SHOW_HEADER					"BIS_EGSpectator_showHeader"
#define VAR_SHOW_LISTS					"BIS_EGSpectator_showLists"
#define VAR_WHITELISTED_SIDES			"BIS_EGSpectator_whitelistedSides"
#define VAR_EXCLUDED_UNIT				"BIS_EGSpectator_excludedUnit"
#define VAR_EXCLUDED_VEHICLE			"BIS_EGSpectator_excludedVehicle"
#define VAR_FIRED						"BIS_EGSpectator_fired"
#define VAR_HIGHLIGHT_TIME				"BIS_EGSpectator_unitHighlightTime"
#define VAR_UNITS_ICONS_TO_DRAW			"BIS_EGSpectator_unitsIconsToDraw"
#define VAR_SHOW_AI_GROUPS				"BIS_EGSpectator_showAiGroups"
#define VAR_OBJECT_BBD					"BIS_EGSpectator_objectBBD"
#define VAR_ENTITY_RESPAWNED			"BIS_EGSpectator_entityRespawned"
#define VAR_EVENT_FIRED					"BIS_EGSpectator_entityFired"
#define VAR_VIEW_DISTANCE				"BIS_EGSpectator_viewDistance"
#define VAR_PROJECTILES					"BIS_EGSpectator_projectiles"
#define VAR_GRENADES					"BIS_EGSpectator_grenades"
#define VAR_DRAW_PROJECTILES_PATH		"BIS_EGSpectator_drawProjectilesPath"
#define MAX_PROJECTILES					50
#define MAX_PROJECTILE_SEGMENTS			50
#define MAX_GRENADES					10
#define GRENADE_ICON					"A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_connect_ca.paa"

/**
 * Spectator Camera
 */
#define VAR_CAMERA						"BIS_EGSpectatorCamera_camera"
#define VAR_CAMERA_TYPE					"BIS_EGSpectatorCamera_cameraType"
#define VAR_CAMERA_MODE					"BIS_EGSpectatorCamera_cameraMode"
#define VAR_CAMERA_TICK					"BIS_EGSpectatorCamera_tick"
#define VAR_CAMERA_LAST_TICK_TIME		"BIS_EGSpectatorCamera_lastTickTime"
#define VAR_CAMERA_DELTA_TIME			"BIS_EGSpectatorCamera_deltaTime"
#define VAR_CAMERA_VISIONMODE			"BIS_EGSpectatorCamera_vision"
#define VAR_CAMERA_MARKER				"BIS_EGSpectatorCamera_cameraMarker"
#define VAR_CAMERA_DUMMY_TARGET			"BIS_EGSpectatorCamera_dummyTarget"
#define VAR_CAMERA_TARGET_IN_VEHICLE	"BIS_EGSpectatorCamera_targetInVehicle"
#define VAR_CAMERA_MANUAL				"BIS_EGSpectatorCamera_manual"
#define VAR_CAMERA_HEIGHT_MODE			"BIS_EGSpectatorCamera_heightMode"
#define VAR_CAMERA_USE_SURFACE_SPEED	"BIS_EGSpectatorCamera_useSurfaceSpeed"
#define VAR_CAMERA_HAS_TARGET			"BIS_EGSpectatorCamera_freeCamHasTarget"
#define VAR_FOLLOW_CAMERA_ZOOM			"BIS_EGSpectatorCamera_zoom"
#define VAR_FOLLOW_CAMERA_ZOOM_TEMP		"BIS_EGSpectatorCamera_zoomTemp"
#define VAR_FOLLOW_CAMERA_DIR_TEMP		"BIS_EGSpectatorCamera_dirTemp"
#define VAR_FOLLOW_CAMERA_YAW			"BIS_EGSpectatorCamera_yaw"
#define VAR_FOLLOW_CAMERA_PITCH			"BIS_EGSpectatorCamera_pitch"
#define VAR_CAMERA_LIGHTS				"BIS_EGSpectatorCamera_lights"
#define VAR_CAMERA_LIGHTS_ON			"BIS_EGSpectatorCamera_lightsOn"
#define VAR_IS_VERY_FAST_SPEED			"BIS_EGSpectatorCamera_isVeryFastSpeed"
#define VAR_TARGET_IN_VEHICLE			"BIS_EGSpectatorCamera_targetInVehicle"
#define TYPE_CINEMATIC					"camera"
#define TYPE_CURATOR					"camcurator"
#define MODE_FREE						"free"
#define MODE_FOLLOW						"follow"
#define MODE_FPS						"fps"
#define CAMERA_TYPES					[TYPE_CINEMATIC, TYPE_CURATOR]
#define CAMERA_MODES					[MODE_FOLLOW, MODE_FPS, MODE_FREE]
#define CAMERA_TARGET_CHANGE_TIME		0.5
#define FOLLOW_CAMERA_MAX_DISTANCE		5.0
#define DISTANCE_GROUPS					2500.0
#define DISTANCE_NAMES					100.0
#define HEIGHT_OFFSET					1.0
#define FIRE_HIGHLIGHT_TIME				0.05
#define SPEED_DEFAULT					0.1
#define SPEED_FAST						2.0
#define SPEED_VERYFAST					3.0

 /**
  * Spectator Draw
  */
#define VAR_GROUP_COLOR					"BIS_EGSpectatorDraw3D_groupColor"
#define VAR_DRAW_3D_LOCATIONS			"BIS_EGSpectatorDraw3D_drawLocations"
#define VAR_VEHICLE_TEXTURE				"BIS_EGSpectatorDraw2D_vehicleTexture"
#define VAR_SIDE_COLOR					"BIS_EGSpectatorDraw2D_sideColor"

/**
 * RscDisplayEGSpectator
 */
#define VAR_DISPLAY 					"RscEGSpectator_display"
#define VAR_LOOP 						"RscEGSpectator_loop"
#define VAR_TICK 						"RscEGSpectator_tick"
#define VAR_LAST_TICK_TIME				"RscEGSpectator_lastTickTime"
#define VAR_KEY_DOWN 					"RscEGSpectator_keyDown"
#define VAR_KEY_UP						"RscEGSpectator_keyUp"
#define VAR_MOUSE_BUTTON_DOWN			"RscEGSpectator_mouseButtonDown"
#define VAR_MOUSE_BUTTON_UP				"RscEGSpectator_mouseButtonUp"
#define VAR_MOUSE_DBL_BUTTON_DOWN		"RscEGSpectator_mouseDblButtonDown"
#define VAR_MOUSE_Z_CHANGED				"RscEGSpectator_mouseZChanged"
#define VAR_MOUSE_MOVING				"RscEGSpectator_mouseMoving"
#define VAR_IS_HOLDING_RIGHT_M_BUTTON	"RscEGSpectator_isHoldingRightMouseButton"
#define VAR_CHILD_DESTROYED 			"RscEGSpectator_childDestroyed"
#define VAR_LAST_PLAYER_INDEX			"RscEGSpectator_lastPlayerIndex"
#define VAR_INTERFACE_VISIBLE			"RscEGSpectator_interfaceVisible"
#define VAR_TIME_LEFT					"RscEGSpectator_timeLeft"
#define VAR_CURSOR_OBJECT				"RscEGSpectator_cursorObject"
#define VAR_FOCUS						"RscEGSpectator_focus"
#define VAR_OLD_FOCUS					"RscEGSpectator_oldFocus"
#define VAR_OLD_FOCUS_INFO				"RscEGSpectator_oldFocusInfo"
#define VAR_MARKERS						"RscEGSpectator_markers"
#define VAR_TREE_MOUSE_ENTER			"RscEGSpectator_treeMouseEnter"
#define VAR_TREE_MOUSE_EXIT				"RscEGSpectator_treeMouseExit"
#define VAR_ENTITIES_LIST_OLD			"RscEGSpectator_entitiesListOld"
#define VAR_LOCATIONS_LIST_OLD			"RscEGSpectator_locationsListOld"
#define VAR_LIST_TYPE					"RscEGSpectator_listType"
#define VAR_TREE_PLAYER_CLICKED			"RscEGSpectator_treePlayerClicked"
#define VAR_TREE_PLAYER_DBL_CLICKED		"RscEGSpectator_treePlayerDblClicked"
#define VAR_CAM_BUTTON_CLICKED			"RscEGSpectator_camButtonClicked"
#define VAR_TABS_CLICKED				"RscEGSpectator_tabEntitiesClicked"
#define VAR_TABS_MOUSE_ENTER			"RscEGSpectator_tabEntitiesMouseEnter"
#define VAR_TABS_MOUSE_EXIT				"RscEGSpectator_tabEntitiesMouseExit"
#define VAR_CAMERA_MODE_CHANGED			"RscEGSpectator_cameraModeChanged"
#define VAR_GAME_PHASE					"RscEGSpectator_gamePhase"
#define VAR_MAP_VISIBLE					"RscEGSpectator_mapVisible"
#define VAR_MAP_CLICKED					"RscEGSpectator_mapMouseButtonClick"
#define VAR_MAP_DRAW					"RscEGSpectator_mapDraw"
#define VAR_MAP_HIGHLIGHTED_OBJECT		"RscEGSpectator_mapHighlightedObject"
#define VAR_HEAD_TO_HEAD_SHOWN			"RscEGSpectator_headToHeadShown"
#define VAR_SIDE_A_TASK					"RscEGSpectator_sideATask"
#define VAR_SIDE_B_TASK					"RscEGSpectator_sideBTask"
#define VAR_SIDE_A_FLASHING				"RscEGSpectator_sideAFlashing"
#define VAR_SIDE_B_FLASHING				"RscEGSpectator_sideBFlashing"
#define VAR_DOUBLE_CLICK_TIME			"RscEGSpectator_doubleClickTime"
#define VAR_DEFAULT_HELP_X				"RscEGSpectator_defaulthelpX"
#define VAR_DEFAULT_HELP_Y				"RscEGSpectator_defaulthelpY"
#define VAR_DEFAULT_HELP_W				"RscEGSpectator_defaulthelpW"
#define VAR_DEFAULT_HELP_H				"RscEGSpectator_defaulthelpH"
#define VAR_FOCUS_WIDGET_VISIBLE		"RscEGSpectator_focusWidgetVisible"
#define VAR_AVAILABLE_INSIGNIAS			"RscEGSpectator_availableInsignias"
#define VAR_CONTROLS_HELP_VISIBLE		"RscEGSpectator_controlsHelpVisible"
#define LIST_ENTITIES					localize "STR_A3_Spectator_Entities"
#define LIST_LOCATIONS					localize "STR_A3_Spectator_Locations"
#define LIST_TYPE						LIST_ENTITIES
#define LIST_UPDATE_RATE				1.0
#define NAME_MAX_CHARACTERS				17
#define MAP_MIN_ENTITY_DISTANCE			30.0
#define LOOP_RATE 						0.25
#define MAX_VIEW_DISTANCE				2500
#define MIN_VIEW_DISTANCE				500
#define DEFAULT_VIEW_DISTANCE			1200
#define DOUBLE_CLICK_DELAY				0.5
#define MAX_CONTROLS_HELP_ENTRIES		12

/**
 * Progress Visualizer
 */
#define VAR_OBJECTS 					"BIS_progressVisualizer_objects"
#define VAR_DISPLAYS 					"BIS_progressVisualizer_displays"

/**
 * Textures
 */
#define ICON_BACKGROUND					"A3\Ui_f\data\IGUI\Cfg\simpleTasks\background1_ca.paa"
#define ICON_DEAD						"a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"
#define ICON_GROUP						"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\GroupIcon_ca.paa"
#define ICON_UNIT						"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\UnitIcon_ca.paa"
#define ICON_REVIVE						"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\ReviveIcon_ca.paa"
#define ICON_BACKGROUND_UNIT			"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\UnitName_ca.paa"
#define ICON_CAMERA						"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\cameraTexture_ca.paa"
#define CAM_ICON_FREE					"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\FreeSelected.paa"
#define CAM_ICON_FREE_SELECTED			"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\Free.paa"
#define CAM_ICON_FOLLOW					"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\FollowSelected.paa"
#define CAM_ICON_FOLLOW_SELECTED		"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\Follow.paa"
#define CAM_ICON_FPS					"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\FpsSelected.paa"
#define CAM_ICON_FPS_SELECTED			"a3\Ui_f\data\GUI\Rsc\RscDisplayEGSpectator\Fps.paa"

/**
 * Colors
 */
#define COLOR_INCAPACITATED				[0.5,0,0,1]

/**
 * Revive
 */
#define VAR_INCAPACITATED				"BIS_revive_incapacitated"
