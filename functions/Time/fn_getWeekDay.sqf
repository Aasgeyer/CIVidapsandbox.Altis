private _date = [_this select 0,_this select 1,_this select 2,0,0];
private _yearBefore = ((_date select 0)-1) max 0;
private _qttLeapYears = floor (_yearBefore/4);
private _qttNormalYears = _yearBefore-_qttLeapYears;
private _days = _qttNormalYears+_qttLeapYears*(366/365);
_days = _days+dateToNumber _date;
(round (_days/(1/365))) mod 7