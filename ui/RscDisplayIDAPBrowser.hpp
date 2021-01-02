#define COLOR_IDAP {0.784314,0.286275,0,1}
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
		class _LNBCATCHER: TER_RscText
		{
			idc = -1;
			x = 0;
			y = 0;
			w = 0;
			h = 0;
		};
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
					colorBackground[] = GUI_BCG_COLOR;
				};
				class HeadbarTitle: TER_RscStructuredText
				{
					text = "<t color='#FB5B00'><img image='\a3\ui_f_orange\Data\Displays\RscDisplayOrangeChoice\faction_idap_ca.paa'/></t>IDAP Organizer - v1.0";
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
					text = "ui\data\RscDisplayIDAPBrowser\maximize_ca.paa";
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
				class Background: TER_RscText
				{
					x = 0;
					y = 0;
					w = 10 * GUI_GRID_W;
					h = safeZoneH - 1 * GUI_GRID_H;
					colorBackground[] = {0,0,0,0.8};
				};
				class Title: TER_RscStructuredText
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
				class Activity: TER_RscButton
				{
					text = "Activity";
					group = "GroupActivity";
					x = 0;
					y = 6 * GUI_GRID_H;
					w = 10 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					colorText[] = {1,1,1,1};
					shadow = 0;
					colorBackground[] = {0.3,0.3,0.3,1};
					colorBackgroundActive[] = COLOR_IDAP;
					colorFocused[] = COLOR_IDAP;
				};
				class Finances: Activity
				{
					text = "Finances";
					y = 7.5 * GUI_GRID_H;
				};
				class Garage: Activity
				{
					text = "Garage";
					group = "GroupGarage";
					y = 9 * GUI_GRID_H;
				};
				class Prices: Activity
				{
					text = "Prices";
					group = "GroupPrices";
					y = 10.5 * GUI_GRID_H;
				};

				class Credits: Activity
				{
					text = "Credits";
					y = safeZoneH - 3.6 * GUI_GRID_H;
				};
				
				class Close: Activity
				{
					idc = 2;
					text = "Close";
					y = safeZoneH - 2.1 * GUI_GRID_H;
				};
			};
		};
		#define W_GROUP (safeZoneW - 10 * GUI_GRID_W)
		#define H_GROUP (safeZoneH - 4 * GUI_GRID_H)
		class ContentHeaderBackground: TER_RscText
		{
			x = safeZoneX + 10 * GUI_GRID_W;
			y = SafeZoneY + 1 * GUI_GRID_H;
			w = W_GROUP;
			h = 3 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.8};
		};
		class ContentTitle: TER_RscStructuredText
		{
			text = "";
			x = safeZoneX + 10 * GUI_GRID_W;
			y = SafeZoneY + 1 * GUI_GRID_H;
			w = W_GROUP;
			h = 2 * GUI_GRID_H;
			class Attributes: Attributes
			{
				size = 2;
				align = "center";
			};
		};
		class ContentDescription: TER_RscStructuredText
		{
			text = "";
			x = safeZoneX + 10 * GUI_GRID_W;
			y = SafeZoneY + 3 * GUI_GRID_H;
			w = W_GROUP;
			h = 1 * GUI_GRID_H;
		};
		groups[] = {"GroupActivity", "GroupPrices", "GroupGarage"};
		class GroupActivity: TER_RscControlsGroupNoScrollbars
		{
			show = 0;
			textTitle = "IDAPAS";
			textDescription = "The following events have been reported to the IDAP Acitivity System (IDAPAS):";
			x = safeZoneX + 10 * GUI_GRID_W;
			y = safeZoneY + 4 * GUI_GRID_H;
			w = W_GROUP;
			h = H_GROUP;
			class controls
			{
				#define W_CT 0.5 * W_GROUP - 1 * GUI_GRID_W
				class List: TER_RscControlsTable
				{
					x = 0.5 * GUI_GRID_W;
					y = 3.5 * GUI_GRID_H;
					w = W_CT;
					h = H_GROUP - 3.5 * GUI_GRID_H;
					lineSpacing = 0.5 * GUI_GRID_CENTER_H;
					rowHeight = 5 * GUI_GRID_CENTER_H;

					class RowTemplate
					{
						class Background
						{
							controlBaseClassPath[] = {"RscText"};
							columnX = 0;
							controlOffsetY = 0;
							columnW = W_CT;
							controlH = 5 * GUI_GRID_CENTER_H;
						};
						class Title: Background
						{
							controlBaseClassPath[] = {"RscStructuredText"};
							controlH = 1 * GUI_GRID_CENTER_H;
						};
						class Content: Title
						{
							controlOffsetY = 1 * GUI_GRID_CENTER_H;
							controlH = 4 * GUI_GRID_CENTER_H;
						};
						class More: Title
						{
							controlBaseClassPath[] = {"RscButtonMenu"};
							columnX = W_CT - 10 * GUI_GRID_CENTER_W;
							//controlOffsetY = 4 * GUI_GRID_CENTER_H;
							columnW = 10 * GUI_GRID_CENTER_W;
						};
					};
				};
			};
		};
		class GroupPrices: GroupActivity
		{
			show = 0;
			textTitle = "Price List";
			textDescription = "Prices of the different assets that are available for purchase.";
			class controls
			{
				class Background: TER_RscText
				{
					x = 0;
					y = 0;
					w = W_GROUP;
					h = H_GROUP;
					colorBackground[] = {0.48,0.52,0.51,1};
				};
				class Sort: TER_RscCombo
				{
					x = 0.5 * GUI_GRID_W;
					y = 0.5 * GUI_GRID_H;
					w = 10 * GUI_GRID_W;
					h = 1 * GUI_GRID_H;
					class Items
					{
						class Default
						{
							text = "Sort by...";
							value = 0;
							default = 1;
						};
						class Name
						{
							text = "Name";
							value = 1;
						};
						class Price
						{
							text = "Price";
							value = 2;
						};
					};
				};
				class Order: Sort
				{
					x = 11 * GUI_GRID_W;
					class Items
					{
						class Default
						{
							text = "Order...";
							value = 0;
							default = 1;
						};
						class Ascending
						{
							text = "Ascending";
							value = 1;
						};
						class Descending
						{
							text = "Descending";
							value = 2;
						};
					};
				};
				#define _HROW 7.5
				class List: TER_RscControlsTable
				{
					x = 0;
					y = 2 * GUI_GRID_H;
					w = W_GROUP;
					h = H_GROUP - 2.5 * GUI_GRID_H;
					rowHeight = _HROW * GUI_GRID_H;
					selectedRowColorFrom[] = {0,0,0,0};
					selectedRowColorTo[] = {0,0,0,0};
					class RowTemplate
					{
						#define _WIMAGE (16/9 * 4)
						class Frame
						{
							controlBaseClassPath[] = {"RscFrame"};
							columnX = 0.5 * GUI_GRID_W;
							controlOffsetY = pixelH;
							columnW = W_GROUP - 1 * GUI_GRID_W - 0.021;
							controlH = _HROW * GUI_GRID_H;
						};
						class Image
						{
							controlBaseClassPath[] = {"RscPicture"};
							columnX = 1 * GUI_GRID_W;
							controlOffsetY = 1.5 * GUI_GRID_H;
							columnW = _WIMAGE * GUI_GRID_W;
							controlH = 4 * GUI_GRID_H;
						};
						class Name: Image
						{
							controlBaseClassPath[]= {"RscStructuredText"};
							columnX = 1 * GUI_GRID_W;
							controlOffsetY = 0.5 * GUI_GRID_H;
							controlH = 1 * GUI_GRID_H;
							columnW = W_GROUP - 2.5 * GUI_GRID_W;
						};
						class Description: Name
						{
							columnX = (1 + _WIMAGE) * GUI_GRID_W;
							controlOffsetY = 1.5 * GUI_GRID_H;
							columnW = W_GROUP - (2 + _WIMAGE) * GUI_GRID_W;
							controlH = _HROW * GUI_GRID_H;
						};
						class Price: Name
						{
							controlOffsetY = 5.5 * GUI_GRID_H;
							columnW = _WIMAGE * GUI_GRID_W;
							controlH = 1.5 * GUI_GRID_H;
						};
						#undef _WIMAGE
					};
					class VScrollBar: VScrollBar
					{
						width = 0.7 * GUI_GRID_W;
					};
				};
				#undef _HROW
			};
		};
		class GroupGarage: GroupActivity
		{
			show = 1;
			textTitle = "Stored Vehicles";
			textDescription = "Purchased vehicles that were stored in the garage.";
			class controls
			{
				#define _HROW 5
				#define _WIMAGE ((_HROW - 1)*16/9)
				#define _W_LIST (1.5 + _WIMAGE + 10)
				class List: TER_RscControlsTable
				{
					x = 0.5 * W_GROUP - 0.5 * _W_LIST * GUI_GRID_W;
					y = 0;
					w = _W_LIST * GUI_GRID_W;
					h = H_GROUP - 3.1 * GUI_GRID_H;
					selectedRowColorFrom[] = {0,0,0,0};
					selectedRowColorTo[] = {0,0,0,0};
					rowHeight = _HROW * GUI_GRID_H;
					class RowTemplate
					{
						class Image
						{
							controlBaseClassPath[] = {"RscPicture"};
							columnX = 0.5 * GUI_GRID_W;
							controlOffsetY = 0.5 * GUI_GRID_H;
							columnW = _WIMAGE * GUI_GRID_W;
							controlH = (_HROW - 1) * GUI_GRID_H;
						};
						class Name: Image
						{
							controlBaseClassPath[] = {"RscStructuredText"};
							columnX = (_WIMAGE + 1) * GUI_GRID_W;
							columnW = 10 * GUI_GRID_W;
							controlH = 1 * GUI_GRID_H;
						};
						class Retrieve: Image
						{
							controlBaseClassPath[] = {"RscButton"};
							columnX = (_WIMAGE + 1) * GUI_GRID_W;
							controlOffsetY = 1.6 * GUI_GRID_H;
							columnW = 10 * GUI_GRID_W;
							controlH = 2 * GUI_GRID_H;
						};
					};
				};
				class StatusLabel: TER_RscStructuredText
				{
					text = "Status";
					x = 0;
					y = H_GROUP - 2.5 * GUI_GRID_H;
					w = W_GROUP;
					h = 1.5 * GUI_GRID_H;
					class Attributes: Attributes
					{
						size = 1.5;
					};
				};
				class Status: StatusLabel
				{
					text = "Waiting...";
					y = H_GROUP - 1 * GUI_GRID_H;
					h = 1 * GUI_GRID_H;
					class Attributes: Attributes
					{
						size = 1;
					};
				};
			};
		};
	};
};