// W78C438C processor definition file
// ==================================


unit Sys_W78C438C;

interface

var
  HB        : byte absolute $A1;
  EPMA      : byte absolute $A2;
  P8        : byte absolute $A6;
  XICON     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;

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


const
  TIMER2    = $2B;
  EXTI2     = $33;
  EXTI3     = $3B;

implementation

end.
