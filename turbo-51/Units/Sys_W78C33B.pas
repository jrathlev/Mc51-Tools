// W78C33B processor definition file
// =================================
// W78C33B, W78L33


unit Sys_W78C33B;

interface

var
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  P4        : byte absolute $D8;

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
