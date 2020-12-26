class RscDisplayReports
{
	idd = -1;
	INIT_MISSION_DISPLAY(RscDisplayReports)
	class controlsBackground
	{
		class Background: TER_RscText
		{
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = GUI_GRID_CENTER_WAbs;
			h = GUI_GRID_CENTER_HAbs - 2.2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,0,0,0.8};
		};
		class Title: TER_RscText
		{
			text = "IDAP Reports, Altis And Stratis Mission";
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = GUI_GRID_CENTER_WAbs;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = GUI_BCG_COLOR;
		};
		class Entries: TER_RscControlsTable
		{
			idc = 101;
			x = GUI_GRID_CENTER_X + 0.5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.6 * GUI_GRID_CENTER_H;
			w = 39 * GUI_GRID_CENTER_W;
			h = GUI_GRID_CENTER_HAbs - 3.4 * GUI_GRID_CENTER_H;
			rowHeight = 5 * GUI_GRID_CENTER_H;
			class RowTemplate
			{
				class Background
				{
					controlBaseClassPath[] = {"RscText"};
					columnX = 0;
					controlOffsetY = 0;
					columnW = 39 * GUI_GRID_CENTER_W;
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
					columnX = 29 * GUI_GRID_CENTER_W;
					//controlOffsetY = 4 * GUI_GRID_CENTER_H;
					columnW = 10 * GUI_GRID_CENTER_W;
				};
			};
		};
		class Close: TER_RscButtonMenuCancel
		{
			text = "CLOSE";
			x = GUI_GRID_CENTER_X + GUI_GRID_CENTER_WAbs - 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + GUI_GRID_CENTER_HAbs - 1 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
	class controls
	{

	};
};