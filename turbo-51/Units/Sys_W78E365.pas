// W78E365 processor definition file
// =================================
// Winbond W78E365, W78E365A, W78E65, W78E065A, W78L365A, W78LE365


unit Sys_W78E365;

interface

var
  P40AL     : byte absolute $84;
  P40AH     : byte absolute $85;
  POR       : byte absolute $86;
  AUXR      : byte absolute $8E;
  WDTC      : byte absolute $8F;
  P41AL     : byte absolute $94;
  P41AH     : byte absolute $95;
  XRAMAH    : byte absolute $A1;
  P42AL     : byte absolute $AC;
  P42AH     : byte absolute $AD;
  P4CSIN    : byte absolute $AE;
  P43AL     : byte absolute $B4;
  P43AH     : byte absolute $B5;
  CHPCON    : byte absolute $BF;
  XICON     : byte absolute $C0;
  P4CONA    : byte absolute $C2;
  P4CONB    : byte absolute $C3;
  SFRAL     : byte absolute $C4;
  SFRAH     : byte absolute $C5;
  SFRFD     : byte absolute $C6;
  SFRCN     : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMCON2   : byte absolute $CE;
  PWM4      : byte absolute $CF;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package
  PWMP      : byte absolute $D9;
  PWM0      : byte absolute $DA;
  PWM1      : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2      : byte absolute $DD;
  PWM3      : byte absolute $DE;
  CHPENR    : byte absolute $F6;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  IT2       : boolean absolute $C0;
  IE2       : boolean absolute $C1;
  EX2       : boolean absolute $C2;
  PX2       : boolean absolute $C3;
  IT3       : boolean absolute $C4;
  IE3       : boolean absolute $C5;
  EX3       : boolean absolute $C6;
  PX3       : boolean absolute $C7;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  INT3      : boolean absolute $DA;  // not present at the 40-pin DIP package
  INT2      : boolean absolute $DB;  // not present at the 40-pin DIP package


const
  TIMER2    = $2B;
  EXTI2     = $33;
  EXTI3     = $3B;

implementation

end.
