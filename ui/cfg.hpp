#undef INIT_DISPLAY
#define INIT_MISSION_DISPLAY(NAME) \
	onLoad = ['onLoad', _this, 'NAME'] call TER_fnc_initDisplay;\
	onUnload = ['onUnload', _this, 'NAME'] call TER_fnc_initDisplay;\
	scriptName = NAME;

#define RGBA255to1(COLOR_R,COLOR_G,COLOR_B,COLOR_A)\
	__EVAL(COLOR_R * 0.00392157),\
	__EVAL(COLOR_G * 0.00392157),\
	__EVAL(COLOR_B * 0.00392157),\
	__EVAL(COLOR_A * 0.00392157)

#include "controls.hpp"
#include "RscDisplayFinancialReport.hpp"
#include "RscDisplayReports.hpp"
#include "RscDisplayIDAPBrowser.hpp"