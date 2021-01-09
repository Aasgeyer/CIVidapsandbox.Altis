class RscDisplayVehicleRepair
{
	idd = -1;
	INIT_MISSION_DISPLAY(RscDisplayVehicleRepair)
	class controlsBackground
	{
		class Background: TER_RscText
		{
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 15 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,0,0,0.8};
		};
		class Title: TER_RscText
		{
			text = "Mechanic";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 3.9 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = GUI_BCG_COLOR;
		};
	};
	class controls
	{
		class VehicleName: TER_RscStructuredText
		{
			text = "Vehicle Name";
			x = GUI_GRID_CENTER_X + 10.1 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5.1 * GUI_GRID_CENTER_H;
			w = 19.8 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class LabelRepairCost: VehicleName
		{
			text = "Repair cost:";
			y = GUI_GRID_CENTER_Y + 6.2 * GUI_GRID_CENTER_H;
			w = 9.8 * GUI_GRID_CENTER_W;
		};
		class RepairCost: LabelRepairCost
		{
			text = "9 999 999 $";
			x = GUI_GRID_CENTER_X + 19.9 * GUI_GRID_CENTER_W;
		};
		class LabelCurrentMoney: LabelRepairCost
		{
			text = "Current money:";
			y = GUI_GRID_CENTER_Y + 7.3 * GUI_GRID_CENTER_H;
		};
		class CurrentMoney: RepairCost
		{
			y = GUI_GRID_CENTER_Y + 7.3 * GUI_GRID_CENTER_H;
		};
		class CatcherButton: TER_RscButtonMenu
		{
			x = 0;
			y = 0;
			w = 0;
			h = 0;
			default = 1;
		};
		class Repair: TER_RscButtonMenu
		{
			idc = 1;
			text = "Repair";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 20.1 * GUI_GRID_CENTER_H;
			w = 9.9 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class Cancel: TER_RscButtonMenuCancel
		{
			x = GUI_GRID_CENTER_X + 20.1 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 20.1 * GUI_GRID_CENTER_H;
			w = 9.9 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
	};
};