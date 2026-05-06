// AT87F51RC processor definition file
// ===================================


unit Sys_87F51RC;

interface

var
  DP0L      : byte absolute $82;
  DP0H      : byte absolute $83;
  DP1L      : byte absolute $84;
  DP1H      : byte absolute $85;
  AUXR      : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


const
  TIMER2    = $2B;

implementation

end.
