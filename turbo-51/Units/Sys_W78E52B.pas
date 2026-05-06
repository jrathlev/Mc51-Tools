// W78E52B processor definition file
// =================================
// Winbond W78E52B, W78E52C, W78E052C, W78C52D, W78C052D,
// W78E54B, W78E54C, W78E054C, W78L52, W78L052A,
// W78L052C, W78L54, W78L054A, W78L054C, W78LE52,
// W78LE52C, W78LE54, W78LE54C, W78IE52, W78IE54


unit Sys_W78E52B;

interface

var
  AUXR      : byte absolute $8E;
  WDTC      : byte absolute $8F;
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
