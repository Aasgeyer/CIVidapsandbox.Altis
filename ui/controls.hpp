#include "\a3\ui_f\hpp\defineCommon.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"
#define CT_CONTROLS_TABLE 19
class TER_RscObject
{
	access = 0;
	type = CT_OBJECT;
	scale = 1;
	direction[] = {0,0,1};
	up[] = {0,1,0};
	shadow = 0;
};
class TER_RscText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = ST_LEFT;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "RobotoCondensed";
	SizeEx = GUI_TEXT_SIZE_MEDIUM;
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class TER_RscFrame
{
	type = CT_STATIC;
	idc = -1;
	deletable = 0;
	style = ST_FRAME;
	shadow = 2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "RobotoCondensed";
	sizeEx = 0.02;
	text = "";
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
};
class TER_RscLine: TER_RscText
{
	idc = -1;
	style = ST_MULTI + ST_TITLE_BAR + ST_HUD_BACKGROUND;
	x = 0.17;
	y = 0.48;
	w = 0.66;
	h = 0;
	text = "";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
};
class TER_RscProgress
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_PROGRESS;
	style = ST_HORIZONTAL;
	colorFrame[] = {0,0,0,0};
	colorBar[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class TER_RscPicture
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	style = ST_MULTI + ST_TITLE_BAR;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class TER_RscPictureKeepAspect: TER_RscPicture
{
	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class TER_RscVideo: TER_RscPicture
{
	autoplay = 1;
	loops = 1;
};
class TER_RscHTML
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_HTML;
	idc = -1;
	style = ST_LEFT;
	filename = "";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	colorBold[] = {1,1,1,1};
	colorLink[] = {1,1,1,0.75};
	colorLinkActive[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureLink[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureBorder[] = {0,0,0,0};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class H1
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_LARGE;
		align = "left";
	};
	class H2
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "right";
	};
	class H3
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "left";
	};
	class H4
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "left";
	};
	class H5
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "left";
	};
	class H6
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "left";
	};
	class P
	{
		font = "RobotoCondensed";
		fontBold = "RobotoCondensedBold";
		sizeEx = GUI_TEXT_SIZE_MEDIUM;
		align = "left";
	};
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.1;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	prevPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_left_ca.paa";
	nextPage = "\A3\ui_f\data\gui\rsccommon\rschtml\arrow_right_ca.paa";
	shadow = 2;
};
class TER_RscButton
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_BUTTON;
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0,0,0,1};
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	idc = -1;
	style = ST_CENTER;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	url = "";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};
class TER_RscShortcutButton
{
	deletable = 0;
	fade = 0;
	type = CT_SHORTCUTBUTTON;
	x = 0.1;
	y = 0.1;
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		w = GUI_TEXT_SIZE_MEDIUM * (3/4);
		h = GUI_TEXT_SIZE_MEDIUM;
	};
	class TextPos
	{
		left = GUI_TEXT_SIZE_MEDIUM * (3/4);
		top = ((GUI_GRID_HAbs / 20) - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	colorFocused[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackgroundFocused[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	colorBackground2[] = {1,1,1,1};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = ST_LEFT;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = (GUI_GRID_HAbs / 20);
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {1,1,1,1};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "RobotoCondensed";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "RobotoCondensed";
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	text = "";
	url = "";
	action = "";
	class AttributesImage
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
};
class TER_RscEdit
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_EDIT;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0,0,0,0};
	colorText[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		1
	};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = ST_FRAME;
	font = "RobotoCondensed";
	shadow = 2;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class TER_RscCombo
{
	idc = -1;
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_COMBO;
	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorScrollbar[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};
	maxHistoryDelay = 1;
	class ComboScrollBar: ScrollBar
	{
		color[] = {1,1,1,1};
	};
	style = ST_MULTI + ST_NO_RECT;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelectBackground[] = {1,1,1,0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] = {1,0,0,1};
};
class TER_RscListBox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_LISTBOX;
	rowHeight = 0;
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorScrollbar[] = {1,0,0,0};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,0.3};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscListbox\soundSelect",
		0.09,
		1
	};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class ListScrollBar: ScrollBar
	{
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
	style = LB_TEXTURES;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	period = 1.2;
	maxHistoryDelay = 1;
};
class TER_RscListNBox
{
	idc = -1;
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_LISTNBOX;
	rowHeight = 0;
	colorText[] = {1,1,1,1};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,1};
	maxHistoryDelay = 1;
	soundSelect[] =
	{
		"",
		0.1,
		1
	};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	drawSideArrows = 0;
	columns[] = {0.3,0.6,0.7};
	idcLeft = -1;
	idcRight = -1;
	class ListScrollBar: ScrollBar
	{
	};
	style = ST_MULTI;
	shadow = 0;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	color[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	period = 1.2;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
	class ScrollBar: ScrollBar
	{
	};
};
class TER_RscXListBox
{
	deletable = 0;
	fade = 0;
	idc = -1;
	type = CT_XLISTBOX;
	x = 0.1;
	y = 0.1;
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorText[] = {1,1,1,1};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscListbox\soundSelect",
		0.09,
		1
	};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	style = ST_CENTER + LB_TEXTURES + SL_HORZ;
	shadow = 2;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	w = 0.14706;
	h = 0.039216;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
};
class TER_RscTree
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_TREE;
	colorBackground[] = {0,0,0,0};
	colorSelect[] = {1,1,1,0.7};
	colorDisabled[] = {1,1,1,0.25};
	colorText[] = {1,1,1,1};
	colorSelectText[] = {0,0,0,1};
	colorBorder[] = {0,0,0,0};
	colorSearch[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	colorMarked[] = {0.2,0.3,0.7,1};
	colorMarkedText[] = {0,0,0,1};
	colorMarkedSelected[] = {0,0.5,0.5,1};
	multiselectEnabled = 0;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {0,0,0,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {0,0,0,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorArrow[] = {1,1,1,1};
	maxHistoryDelay = 1;
	shadow = 0;
	style = ST_LEFT;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.2;
	rowHeight = 0.0439091;
	colorSelectBackground[] = {0,0,0,0.5};
	colorLines[] = {0,0,0,0};
	borderSize = 0;
	expandOnDoubleclick = 1;
	class ScrollBar: ScrollBar
	{
	};
};
class TER_RscSlider
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_SLIDER;
	style = SL_HORZ;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.025;
};
class TER_RscXSliderH
{
	deletable = 0;
	fade = 0;
	type = CT_XSLIDER;
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisable[] = {1,1,1,0.4};
	style = SL_TEXTURES + SL_HORZ;
	shadow = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	colorDisabled[] = {1,1,1,0.2};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class TER_RscActiveText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_ACTIVETEXT;
	style = ST_CENTER;
	color[] = {0,0,0,1};
	colorActive[] = {0.3,0.4,0,1};
	colorDisabled[] = {1,1,1,0.25};
	soundEnter[] =
	{
		"",
		0.1,
		1
	};
	soundPush[] =
	{
		"",
		0.1,
		1
	};
	soundClick[] =
	{
		"",
		0.1,
		1
	};
	soundEscape[] =
	{
		"",
		0.1,
		1
	};
	text = "";
	default = 0;
	idc = -1;
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.035;
	font = "RobotoCondensed";
	shadow = 2;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	url = "";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};
class TER_RscActivePicture: TER_RscActiveText
{
	style = ST_MULTI + ST_TITLE_BAR;
	color[] = {1,1,1,0.5};
	colorActive[] = {1,1,1,1};
};
class TER_RscActivePictureKeepAspect: TER_RscActivePicture
{
	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class TER_RscStructuredText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	style = ST_LEFT;
	colorText[] = {1,1,1,1};
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#ffffff";
		colorLink = "#D09B43";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = GUI_TEXT_SIZE_MEDIUM;
	shadow = 1;
};
class TER_RscToolbox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_TOOLBOX;
	style = ST_CENTER;
	colorText[] = {0.95,0.95,0.95,1};
	color[] = {0.95,0.95,0.95,1};
	colorTextSelect[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0.95,0.95,0.95,1};
	colorTextDisable[] = {0.4,0.4,0.4,1};
	colorDisable[] = {0.4,0.4,0.4,1};
	colorSelectedBg[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		0.5
	};
	shadow = 0;
	strings[] =
	{
		"",
		""
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.025;
	rows = 1;
	columns = 2;
	font = "RobotoCondensed";
	sizeEx = GUI_TEXT_SIZE_SMALL;
};
class TER_RscControlsGroup
{
	deletable = 0;
	fade = 0;
	class VScrollbar: ScrollBar
	{
		color[] = {1,1,1,1};
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar: ScrollBar
	{
		color[] = {1,1,1,1};
		height = 0.028;
	};
	class Controls
	{
	};
	type = CT_CONTROLS_GROUP;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = ST_MULTI;
};
class TER_RscControlsGroupNoScrollbars: TER_RscControlsGroup
{
	class VScrollbar: VScrollbar
	{
		width = 0;
	};
	class HScrollbar: HScrollbar
	{
		height = 0;
	};
};
class TER_RscControlsGroupNoHScrollbars: TER_RscControlsGroup
{
	class HScrollbar: HScrollbar
	{
		height = 0;
	};
};
class TER_RscControlsGroupNoVScrollbars: TER_RscControlsGroup
{
	class VScrollbar: VScrollbar
	{
		width = 0;
	};
};
class TER_RscButtonTextOnly: TER_RscButton
{
	SizeEx = GUI_TEXT_SIZE_SMALL;
	colorBackground[] = {1,1,1,0};
	colorBackgroundActive[] = {1,1,1,0};
	colorBackgroundDisabled[] = {1,1,1,0};
	colorFocused[] = {1,1,1,0};
	colorShadow[] = {1,1,1,0};
	borderSize = 0;
};
class TER_RscButtonMenu: TER_RscShortcutButton
{
	idc = -1;
	type = CT_SHORTCUTBUTTON;
	style = ST_CENTER + ST_FRAME + ST_HUD_BACKGROUND;
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = GUI_TEXT_SIZE_MEDIUM;
	fontSecondary = "PuristaLight";
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = GUI_TEXT_SIZE_MEDIUM;
	sizeEx = GUI_TEXT_SIZE_MEDIUM;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = 0.25 * GUI_GRID_W;
		top = (GUI_GRID_H - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = 5.25 * GUI_GRID_W;
		top = 0;
		w = 1 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
		0.09,
		1
	};
};
class TER_RscButtonMenuOK: TER_RscButtonMenu
{
	idc = 1;
	shortcuts[] =
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",
		0.09,
		1
	};
};
class TER_RscButtonMenuCancel: TER_RscButtonMenu
{
	idc = 2;
	shortcuts[] =
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
};
class TER_RscButtonMenuSteam: TER_RscButtonMenu
{
	colorBackground[] = {0.0313726,0.721569,0.917647,1};
	textureNoShortcut = "\A3\Ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa";
	class TextPos
	{
		left = 0.0325;
		top = (GUI_GRID_H - GUI_TEXT_SIZE_MEDIUM) / 2;
		right = 0.005;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.005;
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
};
class TER_RscMapControl
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_MAP_MAIN;
	idc = 51;
	style = ST_MULTI + ST_TITLE_BAR;
	colorBackground[] = {0.969,0.957,0.949,1};
	colorOutside[] = {0,0,0,1};
	colorText[] = {0,0,0,1};
	font = "TahomaB";
	sizeEx = 0.04;
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorRocks[] = {0,0,0,0.3};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorForestBorder[] = {0,0,0,0};
	colorRocksBorder[] = {0,0,0,0};
	colorPowerLines[] = {0.1,0.1,0.1,1};
	colorRailWay[] = {0.8,0.2,0,1};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1,1,1,0.5};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorRoads[] = {0.7,0.7,0.7,1};
	colorMainRoads[] = {0.9,0.5,0.3,1};
	colorTracksFill[] = {0.84,0.76,0.65,1};
	colorRoadsFill[] = {1,1,1,1};
	colorMainRoadsFill[] = {1,0.6,0.4,1};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	stickX[] = {0.2,["Gamma",1,1.5]};
	stickY[] = {0.2,["Gamma",1,1.5]};
	class Legend
	{
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
		x = SafeZoneX + GUI_GRID_W;
		y = SafeZoneY + safezoneH - 4.5 * GUI_GRID_H;
		w = 10 * GUI_GRID_W;
		h = 3.5 * GUI_GRID_H;
		font = "RobotoCondensed";
		sizeEx = GUI_TEXT_SIZE_SMALL;
	};
	class ActiveMarker
	{
		color[] = {0.3,0.1,0.9,1};
		size = 50;
	};
	class Command
	{
		color[] = {1,1,1,1};
		icon = "\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Task
	{
		taskNone = "#(argb,8,8,3)color(0,0,0,0)";
		taskCreated = "#(argb,8,8,3)color(0,0,0,1)";
		taskAssigned = "#(argb,8,8,3)color(1,1,1,1)";
		taskSucceeded = "#(argb,8,8,3)color(0,1,0,1)";
		taskFailed = "#(argb,8,8,3)color(1,0,0,1)";
		taskCanceled = "#(argb,8,8,3)color(1,0.5,0,1)";
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		color[] =
		{
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"
		};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark
	{
		color[] = {1,1,1,1};
		icon = "\a3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Tree
	{
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree
	{
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bush
	{
		color[] = {0.45,0.64,0.33,0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Chapel
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Cross
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Rock
	{
		color[] = {0.1,0.1,0.1,0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
	};
	class Lighthouse
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Quay
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Fuelstation
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Hospital
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class BusStop
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class LineMarker
	{
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
		lineWidthThin = 0.008;
		lineWidthThick = 0.014;
		lineDistanceMin = 3e-005;
		lineLengthMin = 5;
	};
	class Transmitter
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Stack
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.4;
		coefMax = 2;
	};
	class Ruin
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class Tourism
	{
		color[] = {0,0,0,1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
	};
	class Watertower
	{
		color[] = {1,1,1,1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Waypoint
	{
		color[] = {1,1,1,1};
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
	};
	class WaypointCompleted
	{
		color[] = {1,1,1,1};
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\a3\ui_f\data\map\mapcontrol\waypointcompleted_ca.paa";
		size = 18;
	};
	moveOnEdges = 1;
	x = "SafeZoneXAbs";
	y = SafeZoneY + 1.5 * GUI_GRID_H;
	w = "SafeZoneWAbs";
	h = SafeZoneH - 1.5 * GUI_GRID_H;
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	colorTrails[] = {0.84,0.76,0.65,0.15};
	colorTrailsFill[] = {0.84,0.76,0.65,0.65};
	widthRailWay = 4;
	fontLabel = "RobotoCondensed";
	sizeExLabel = GUI_TEXT_SIZE_SMALL;
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = GUI_TEXT_SIZE_SMALL;
	fontNames = "RobotoCondensed";
	sizeExNames = GUI_TEXT_SIZE_SMALL * 2;
	fontInfo = "RobotoCondensed";
	sizeExInfo = GUI_TEXT_SIZE_SMALL;
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	idcMarkerColor = -1;
	idcMarkerIcon = -1;
	textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	showMarkers = 1;
	class power
	{
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class powersolar
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class powerwave
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class powerwind
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Shipwreck
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0,0,0,1};
	};
};
class TER_RscMapControlEmpty: TER_RscMapControl
{
	type = CT_MAP_MAIN;
	ptsPerSquareSea = 1000;
	ptsPerSquareTxt = 1000;
	ptsPerSquareCLn = 1000;
	ptsPerSquareExp = 1000;
	ptsPerSquareCost = 1000;
	ptsPerSquareFor = 1000;
	ptsPerSquareForEdge = 1000;
	ptsPerSquareRoad = 1000;
	ptsPerSquareObj = 1000;
	alphaFadeStartScale = 0;
	alphaFadeEndScale = 0;
	colorBackground[] = {1,1,1,1};
	colorOutside[] = {1,1,1,1};
	colorSea[] = {0,0,0,0};
	colorForest[] = {0,0,0,0};
	colorForestBorder[] = {0,0,0,0};
	colorRocks[] = {0,0,0,0};
	colorRocksBorder[] = {0,0,0,0};
	colorLevels[] = {0,0,0,0};
	colorMainCountlines[] = {0,0,0,0};
	colorCountlines[] = {0,0,0,0};
	colorMainCountlinesWater[] = {0,0,0,0};
	colorCountlinesWater[] = {0,0,0,0};
	colorPowerLines[] = {0,0,0,0};
	colorRailWay[] = {0,0,0,0};
	colorNames[] = {0,0,0,0};
	colorInactive[] = {0,0,0,0};
	colorGrid[] = {0,0,0,0};
	colorGridMap[] = {0,0,0,0};
	class Task: Task
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		iconCreated = "#(argb,8,8,3)color(0,0,0,0)";
		iconCanceled = "#(argb,8,8,3)color(0,0,0,0)";
		iconDone = "#(argb,8,8,3)color(0,0,0,0)";
		iconFailed = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		colorCreated[] = {0,0,0,0};
		colorCanceled[] = {0,0,0,0};
		colorDone[] = {0,0,0,0};
		colorFailed[] = {0,0,0,0};
		size = 0;
	};
	class Waypoint: Waypoint
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class WaypointCompleted: WaypointCompleted
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class CustomMark: CustomMark
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Command: Command
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Bush: Bush
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Rock: Rock
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class SmallTree: SmallTree
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Tree: Tree
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class busstop: BusStop
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class fuelstation: Fuelstation
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class hospital: Hospital
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class church: Church
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class lighthouse: Lighthouse
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class power: power
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powersolar: powersolar
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powerwave: powerwave
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class powerwind: powerwind
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class quay: Quay
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class shipwreck: Shipwreck
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class transmitter: Transmitter
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class watertower: Watertower
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Bunker: Bunker
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Cross: Cross
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Fortress: Fortress
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Fountain: Fountain
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Chapel: Chapel
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Ruin: Ruin
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Stack: Stack
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class Tourism: Tourism
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
	class ViewTower: ViewTower
	{
		icon = "#(argb,8,8,3)color(0,0,0,0)";
		color[] = {0,0,0,0};
		size = 0;
	};
};
class TER_RscCheckBox
{
	idc = -1;
	type = CT_CHECKBOX;
	deletable = 0;
	style = ST_LEFT;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.7};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	textureChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundEnter[] =
	{
		"",
		0.1,
		1
	};
	soundPush[] =
	{
		"",
		0.1,
		1
	};
	soundClick[] =
	{
		"",
		0.1,
		1
	};
	soundEscape[] =
	{
		"",
		0.1,
		1
	};
};
class TER_RscControlsTable
{
	idc = 107;
	x = 0;
	y = 0;
	w = 0;
	h = 0;

	type = CT_CONTROLS_TABLE;
	style = SL_TEXTURES;
	 
	lineSpacing = 0.1 * GUI_GRID_CENTER_H;
	rowHeight = 1 * GUI_GRID_H;
	headerHeight = 1 * GUI_GRID_H;
	 
	firstIDC = 10000;
	lastIDC = 11000;
	 
	// Colours which are used for animation (i.e. change of colour) of the selected line.
	selectedRowColorFrom[]  = {0.95,0.95,0.95,1};
	selectedRowColorTo[]    = {1,1,1,0.5};
	// Length of the animation cycle in seconds.
	selectedRowAnimLength = 1.2;
	 
	class VScrollBar: ScrollBar
	{
		width = 0.021;
		autoScrollEnabled = 0;
		autoScrollDelay = 1;
		autoScrollRewind = 1;
		autoScrollSpeed = 1;
	};
 
	class HScrollBar: ScrollBar
	{
		height = 0.028;
	};
	 
	// Template for selectable rows
	class RowTemplate
	{
		/*
		class NAME
		{
			controlBaseClassPath[] = {"RSCNAME"};
			columnX = 0;
			controlOffsetY = 0;
			columnW = 1;
			controlH = 1;
		};
		*/
	};
	 
	// Template for headers (unlike rows, cannot be selected)
	class HeaderTemplate
	{
	};
};

class TER_RscIDAPSite: TER_RscControlsGroupNoScrollbars
{
	x = safeZoneX;
	y = safeZoneY;
	w = safeZoneW;
	h = safeZoneH;
	class controls
	{
		class BrowserBackground
		{
			x = 0;
			y = 0;
			w = safeZoneW;
			h = safeZoneH;
			colorBackground[] = {1,1,1,1};
		};
	};
};