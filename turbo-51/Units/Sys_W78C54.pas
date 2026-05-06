// W78C54 processor definition file
// ================================
// Winbond W78C54, W78C054A, W78C58, W78E58


unit Sys_W78C54;

interface

var
  AUXR      : byte absolute $8E;
  XICON     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package

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
