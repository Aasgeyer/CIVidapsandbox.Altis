#define COLOR_IDAP {RGBA255to1(200,73,0,255)}
class RscDisplayIDAPBrowser
{
	idd = -1;
	INIT_MISSION_DISPLAY(RscDisplayIDAPBrowser)
	class controlsBackground
	{
		class BrowserBackground: TER_RscText
		{
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = safeZoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		class WatermarkIDAP: TER_RscPictureKeepAspect
		{
			text = "\a3\ui_f_orange\Data\Displays\RscDisplayOrangeChoice\faction_idap_ca.paa";
			colorText[] = {0.5,0.5,0.5,0.1};
			x = safeZoneX + 10 * GUI_GRID_W;
			y = safeZoneY;
			w = safeZoneW - 10 * GUI_GRID_W;
			h = safezoneH;
		};
		
	};
	class controls
	{
		class Headbar: TER_RscControlsGroupNoScrollbars
		{
			text = "IDAP Organizer - v1.0";
			size = 1 * GUI_GRID_H;
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = 1 * GUI_GRID_H;
			class controls
			{
				class HeadbarBackground: TER_RscText
				{
					x = 0;
					y = 0;
					w = safeZoneW;
					h = 1 * GUI_GRID_H;
					colorBackground[] = {RGBA255to1(200,73,0,255)};
				};
				class HeadbarTitle: TER_RscStructuredText
				{
					text = "IDAP Organizer - v1.0";
					x = 0;
					y = 0;
					w = safeZoneW;
					h = 1 * GUI_GRID_H;
				};
				class HeadbarMinimize: TER_RscPicture
				{
					text = "ui\data\RscDisplayIDAPBrowser\reduce_ca.paa";
					colorText[] = {0.8,0.8,0.8,0.5};
					x = safeZoneW - 3.2 * GUI_GRID_W;
					y = 0;
					w = 1 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
				class HeadbarMaximize: HeadbarMinimize
				{
					text = "ui\data\RscDisplayIDAPBrowser\maximize2_ca.paa";
					x = safeZoneW - 2.1 * GUI_GRID_W;
				};
				class HeadbarClose: TER_RscActivePicture
				{
					idc = 2;
					text = "\a3\3den\Data\Displays\Display3DEN\search_end_ca.paa";
					color[] = {1,1,1,1};
					colorActive[] = {0.75,0,0,1};
					x = safeZoneW - 1 * GUI_GRID_W;
					y = 0;
					w = 1 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
				};
			};

		};
		class NavbarLeft: TER_RscControlsGroupNoScrollbars
		{
			x = safeZoneX;
			y = safeZoneY + 1 * GUI_GRID_H;
			w = 10 * GUI_GRID_W;
			h = safeZoneH - 1 * GUI_GRID_H;
			class controls
			{
				class NavbarLeftBackground: TER_RscText
				{
					x = 0;
					y = 0;
					w = 10 * GUI_GRID_W;
					h = safeZoneH - 1 * GUI_GRID_H;
					colorBackground[] = {0,0,0,0.8};
				};
				class NavbarLeftTitle: TER_RscStructuredText
				{
					x = 0;
					y = 0;
					w = 10 * GUI_GRID_W;
					h = 5 * GUI_GRID_H;
					text = "<t size='3'><img image='\a3\ui_f_orange\Data\Displays\RscDisplayOrangeChoice\faction_idap_ca.paa'/>IDAP</t><br/>International Development<br/>and Aid Project";
					class Attributes: Attributes
					{
						size = 1;
						color = "#FB5B00";
						align = "center";
					};
				};
				class NavbarLeftActivity: TER_RscButton
				{
					text = "Activity";
					x = 0;
					y = 6 * GUI_GRID_H;
					w = 10 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					colorText[] = {0,0,0,1};
					shadow = 0;
					colorBackground[] = {1,1,1,1};
					colorBackgroundActive[] = COLOR_IDAP;
					colorFocused[] = {1,1,1,1};
				};
				class NavbarLeftFinances: NavbarLeftActivity
				{
					text = "Finances";
					y = 7.5 * GUI_GRID_H;
				};
				class NavbarLeftReports: NavbarLeftActivity
				{
					text = "Reports";
					y = 9 * GUI_GRID_H;
				};

				class NavbarLeftCredits: NavbarLeftActivity
				{
					text = "Credits";
					y = safeZoneH - 3.6 * GUI_GRID_H;
				};
				
				class NavbarLeftClose: NavbarLeftActivity
				{
					idc = 2;
					text = "Close";
					y = safeZoneH - 2.1 * GUI_GRID_H;
				};
			};
		};
		#define W_GROUP (safeZoneW - 10 * GUI_GRID_W)
		#define H_GROUP (safeZoneH - 1 * GUI_GRID_H)
		class GroupActivity: TER_RscControlsGroupNoScrollbars
		{
			x = safeZoneX + 10 * GUI_GRID_W;
			y = safeZoneY + 1 * GUI_GRID_H;
			w = W_GROUP;
			h = H_GROUP;
			class controls
			{
				class GroupActivityTitle: TER_RscStructuredText
				{
					text = "IDAPAS";
					x = 0;
					y = 0;
					w = W_GROUP;
					h = 2 * GUI_GRID_H;
					colorBackground[] = {0,0,0,0.8};
					class Attributes: Attributes
					{
						size = 2;
						align = "center";
					};
				};
				class GroupActivityDescription: TER_RscStructuredText
				{
					text = "Below is a list of events that have been reported to the IDAP Activity System (IDAPAS):";
					x = 0;
					y = 2 * GUI_GRID_H;
					w = W_GROUP;
					h = 1 * GUI_GRID_H;
				};
			};
		};
	};
};